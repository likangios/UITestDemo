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
//action
#import "BReadMessage.h"

@interface BMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *messageListData;
@property (nonatomic,strong) NSMutableArray *messageOriginListData;

@end

@implementation BMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addRedBackItem];
    [self initCell];
    self.barTitle = @"王宇飞";
    _messageListData = [NSMutableArray array];
    _messageOriginListData = [NSMutableArray array];
    __weak typeof(self) _weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_weakself refreshData];
    }];
    [self.tableView.mj_header beginRefreshing];
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
                [_messageOriginListData addObject:info];
            }];
            [self dealMessageListData];
            
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
    _messageOriginListData = [NSMutableArray array];
    [self getMessageInfoListWithOffset:@0 Limit:Limit_count];
}
- (void)upLoadData{
    NSLog(@"加载");
    [self.tableView.mj_footer beginRefreshing];
    [self getMessageInfoListWithOffset:[NSNumber numberWithInteger:_messageOriginListData.count] Limit:Limit_count];
}
- (void)setMessageReaded:(NSString *)messageUuid_id{
    BReadMessage *action = [[BReadMessage alloc]initWithMessage_ID:messageUuid_id];
    [BUntil showHUDAddedTo:self.view];
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        [BUntil hideAllHUDsForView:self.view];
        BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
        if (result.get_error_code == kServerErrorCode_OK) {
            [[NSNotificationCenter defaultCenter] postNotificationName:KREADMESSAGENOTIFICATION object:nil];
        }
        else{
            [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
        }
    } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
        [BUntil hideAllHUDsForView:self.view];
    }];
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _messageListData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _messageListData[section];
    return array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].getCellHeight;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        NSArray *array = _messageListData[indexPath.section];
        id  rect = array[indexPath.row];
        if ([rect isKindOfClass:[BMessageInfo class]]) {
            BClassRoomPerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BClassRoomPerformanceCell"];
            cell.infoModel = (BMessageInfo *)rect;
            return cell;
        }else{
        BDateTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BDateTimeCell"];
        cell.dateString = (NSString *)rect;
        cell.selected = NO;
        return cell;
        }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = _messageListData[indexPath.section];
    BMessageInfo  *info = array[indexPath.row];
    [self setMessageReaded:info.messageUuid_id];
    NSLog(@"info %@",info);
}
#pragma mark views

- (void)initCell{
    NSArray *classs = @[@"BHomeWorkTCell",@"BClassRoomPerformanceCell",@"BBeforeClassCell",@"BDateTimeCell"];
    for (NSString *classStr in classs) {
        [self.tableView registerNib:[UINib nibWithNibName:classStr bundle:nil] forCellReuseIdentifier:classStr];
    }
    self.tableView.tableFooterView = [[UIView alloc]init];
}
#pragma mark -private method--

- (void)dealMessageListData{
    NSMutableArray *muarray = [NSMutableArray array];
    
    NSMutableArray *timeArr = [NSMutableArray array];
    for (int i = 0; i<_messageListData.count; i++) {
        NSUInteger index;
        BMessageInfo *info = _messageListData[i];
        NSString *timeStr =[self DateFormatter:info.message_createdAt];
        index = [timeArr indexOfObject:timeStr];
        if (index == NSNotFound) {
            [timeArr addObject:timeStr];
        }
    }
    for (int i = 0; i<timeArr.count; i++) {
        NSMutableArray *array = [NSMutableArray array];
        NSString *string = timeArr[i];
        [array addObject:string];
        for (BMessageInfo *info in _messageListData) {
            NSString *timeStr =[self DateFormatter:info.message_createdAt];
            if ([timeStr isEqualToString:string]) {
                [array addObject:info];
            }
        }
        [muarray addObject:array];
    }
    _messageListData = [NSMutableArray arrayWithArray:muarray];
}
- (NSString *)DateFormatter:(NSString *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateString = [dateFormatter dateFromString:date];
    [dateFormatter setDateFormat:@"MM/dd"];
    return [dateFormatter stringFromDate:dateString];
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
