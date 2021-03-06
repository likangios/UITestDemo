//
//  BMainViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/2.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BMainViewController.h"
//controller
#import "BQRCodeViewController.h"
#import "BMessageViewController.h"
#import "BInPutCodeViewController.h"
#import "BInfoConfirmViewController.h"
#import "BSettingViewController.h"
//other
#import "AppDelegate.h"
#import "UINavigationItem+BMargin.h"
//view
#import "BMainCardCell.h"
#import "BQRAlertView.h"
//action
#import "BGetUUIDRelationListAction.h"


@interface BMainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_tableDataList;
}
@property (nonatomic,strong) IBOutlet UIView    *bg_view;

@property (nonatomic,strong) IBOutlet UITableView  *TableView;
@end

@implementation BMainViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableDataList = [NSMutableArray array];
    [self addCustomNavBar];
    [self initCustomBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:KDELETEUUIDNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:KADDUUIDNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:KREADMESSAGENOTIFICATION object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_TableView.mj_header beginRefreshing];
}
- (void)refreshData{
    
    BGetUUIDRelationListAction *action = [[BGetUUIDRelationListAction alloc]init];
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
        if (result.get_error_code == kServerErrorCode_OK) {
            NSArray *array = [result try_get_data_with_array];
            NSLog(@"array ----- %@",array);
            [_tableDataList removeAllObjects];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BUUIDinfoModel *model = [[BUUIDinfoModel alloc]initWithDictionary:obj error:nil];
                [_tableDataList addObject:model];
            }];
            if (_tableDataList.count) {
                self.TableView.hidden = NO;
                self.bg_view.hidden = YES;
            }else{
                self.TableView.hidden = YES;
                self.bg_view.hidden = NO;
            }
            [self.TableView reloadData];
            [self.TableView.mj_header endRefreshing];
        }else{
            [self.TableView.mj_header endRefreshing];
            [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
        }
    } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
        [self.TableView.mj_header endRefreshing];
    }];
    
    NSLog(@"刷新");
    
}
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].getCellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableDataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=  [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BMainCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMainCardCell"];
    if (cell == nil) {
        cell = [[BMainCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BMainCardCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = (BUUIDinfoModel *)_tableDataList[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BUUIDinfoModel *model = (BUUIDinfoModel *)_tableDataList[indexPath.row];
    BMessageViewController *message = [[BMessageViewController alloc]initWithNib];
    message.model = model;
    [self.navigationController pushViewController:message animated:YES];
}
#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y>0){
        _img_shadowView.hidden = NO;
    }else{
        _img_shadowView.hidden = YES;
        
    }
}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    _img_shadowView.hidden = NO;
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    _img_shadowView.hidden = YES;
//}
#pragma mark private
- (void)initCustomBar{
    
    self.barImage = [UIImage imageNamed:@"img_logo_"];
    [self addRightViewWithImage:[UIImage imageNamed:@"icon_set_black_"] hightImage:[UIImage imageNamed:@"icon_set_red_"]];
    [self addLeftViewWithImage:[UIImage imageNamed:@"icon_add_black_"] hightImage:[UIImage imageNamed:@"icon_add_red_"]];
    BCustomRefresh *header = [BCustomRefresh headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.TableView.mj_header = header;
}
#pragma mark action
- (void)setBtn{
    DDLogDebug(@"设置");
}
- (void)reloadNewData{
    
    [self performSelector:@selector(endRef) withObject:nil afterDelay:2];
    
}
- (void)endRef{
    [_TableView.mj_header endRefreshing];
}
#pragma  mark 重写方法
- (void)backAction:(id)sender{
    [BQRAlertView showViewAt:self.view Action1:^{
        DDLogError(@"扫描二维码");
        BQRCodeViewController *qr = [[BQRCodeViewController alloc]initWithNib];
        [qr setQRCodeBlocks:^(BOOL rect,NSString *courseInfo) {
            if (rect) {
                [self dismissViewControllerAnimated:NO completion:^{
            BInfoConfirmViewController *info = [[BInfoConfirmViewController alloc]initWithNib];
                    info.uuid = courseInfo;
                [self.navigationController pushViewController:info animated:YES];
                }];
            }else{
                [self dismissViewControllerAnimated:NO completion:NULL];
            }
        }];
    [self presentViewController:qr animated:YES completion:NULL];
    } Action2:^{
    [self.navigationController pushViewController:[[BInPutCodeViewController alloc]initWithNib] animated:YES];
        DDLogError(@"输入课程码");
    }];
}
-(void)rightAction:(id)sender{
    
    BSettingViewController *set = [[BSettingViewController alloc]initWithNib];
    set.tableviewDataList = _tableDataList;
    [self.navigationController pushViewController:set animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
