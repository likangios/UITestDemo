//
//  BMessageViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/9.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BMessageViewController.h"

#import "BHomeWorkTCell.h"
#import "BClassRoomPerformanceCell.h"
#import "BBeforeClassCell.h"
#import "BDateTimeCell.h"

#import "BGetMessageInfoList.h"

@interface BMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *messageListData;
@end

@implementation BMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addRedBackItem];
    [self initCell];
    self.barTitle = @"王宇飞";
    _messageListData = [NSMutableArray array];
    
    __weak typeof(self) _weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_weakself refreshData];
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [_weakself upLoadData];
    }];
}
- (void)getMessageInfoListWithOffset:(NSNumber *)offset Limit:(NSNumber *)limit_count{
    
    BGetMessageInfoList *action = [[BGetMessageInfoList alloc]initWithOffset:offset Limit:limit_count WithUUID:self.uuid];
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
        if (result.get_error_code == kServerErrorCode_OK) {
            NSArray *array = [result try_get_data_with_array];

            [array bk_each:^(id obj) {
                BMessageInfo *info = [[BMessageInfo alloc]initWithDictionary:obj error:nil];
                [_messageListData addObject:info];
            }];
            [_tableView reloadData];
        }else{
            [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
        
    }];
}
#pragma mark -action-
- (void)refreshData{
    NSLog(@"刷新");
    _messageListData = [NSMutableArray array];
    [self.tableView.mj_header beginRefreshing];
    [self getMessageInfoListWithOffset:@0 Limit:Limit_count];
}
- (void)upLoadData{
    NSLog(@"加载");
    [self.tableView.mj_footer beginRefreshing];
    [self getMessageInfoListWithOffset:@0 Limit:Limit_count];
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].getCellHeight;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0||indexPath.row == 2||indexPath.row == 5) {
        
        BDateTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BDateTimeCell"];
        
        return cell;
    }
    if (indexPath.row == 1||indexPath.row == 6) {
        BHomeWorkTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BHomeWorkTCell"];
        
        return cell;
    }
    if (indexPath.row == 3) {
        BClassRoomPerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BClassRoomPerformanceCell"];
        
        return cell;
    }
    if (indexPath.row == 4) {
        BBeforeClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBeforeClassCell"];
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
    
}
#pragma mark views

- (void)initCell{
    NSArray *classs = @[@"BHomeWorkTCell",@"BClassRoomPerformanceCell",@"BBeforeClassCell",@"BDateTimeCell"];
    for (NSString *classStr in classs) {
        [self.tableView registerNib:[UINib nibWithNibName:classStr bundle:nil] forCellReuseIdentifier:classStr];
    }
    self.tableView.tableFooterView = [[UIView alloc]init];
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
