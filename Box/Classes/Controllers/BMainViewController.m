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

@interface BMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) IBOutlet UITableView  *TableView;
@end

@implementation BMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self initCustomBar];
}

- (IBAction)tuichu:(id)sender {
[(AppDelegate *)[UIApplication sharedApplication].delegate  OnSignoutSuccessful];
}
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[BMessageViewController alloc]initWithNib] animated:YES];
}
#pragma mark private 
- (void)initCustomBar{
    
    self.barImage = [UIImage imageNamed:@"img_logo_"];
    [self addRightViewWithImage:[UIImage imageNamed:@"icon_set_black_"] hightImage:[UIImage imageNamed:@"icon_set_red_"]];
    [self addLeftViewWithImage:[UIImage imageNamed:@"icon_add_black_"] hightImage:[UIImage imageNamed:@"icon_add_red_"]];
    _TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNewData)];
    [_TableView.mj_header beginRefreshing];
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
                [self.navigationController pushViewController:[[BInfoConfirmViewController alloc]initWithNib] animated:YES];
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
    [self.navigationController pushViewController:[[BSettingViewController alloc]initWithNib] animated:YES];
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
