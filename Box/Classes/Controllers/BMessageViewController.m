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
#import "BMessageDetailViewController.h"
//action
#import "BReadMessage.h"

typedef enum : NSUInteger {
    refreshData =1,
    uploadData,
} refreshType;


@interface BMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UIView    *bg_view;

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *messageListData;
@property (nonatomic,strong) NSMutableArray *messageOriginListData;
@property (nonatomic,strong) UILabel *studentNameLabel;
@property (nonatomic,strong) UILabel *studentClassLabel;
@property (nonatomic,strong) UIImageView *teacherAvatar;
@property (nonatomic,strong) UILabel *teacherName;
@property (nonatomic,assign) refreshType reftype;
@end

@implementation BMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addRedBackItem];
    [self initCell];
    [self creatTitleView];
    _messageListData = [NSMutableArray array];
    _messageOriginListData = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:KREADMESSAGENOTIFICATION object:nil];
//    __weak typeof(self) _weakself = self;
    
    BCustomRefresh *header = [BCustomRefresh headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.mj_header = header;
    
    BCustomFoot *foot = [BCustomFoot footerWithRefreshingTarget:self refreshingAction:@selector(upLoadData)];
    foot.stateLabel.text = @"";
    foot.stateLabel.userInteractionEnabled = NO;
    self.tableView.mj_footer = foot;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}
- (void)creatTitleView{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, CustomNavigationBarHeight)];
    view.backgroundColor = [UIColor clearColor];
    
    _studentNameLabel = [[UILabel alloc]init];
    _studentNameLabel.textAlignment = NSTextAlignmentCenter;
    _studentNameLabel.font = [UIFont systemFontOfSize:16];
    _studentNameLabel.textColor=  color_black;
    _studentNameLabel.text = self.model.student_name;
    [view addSubview:_studentNameLabel];
    
    [_studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(22.5);
        make.top.mas_equalTo(12);
    }];
    
    _studentClassLabel = [[UILabel alloc]init];
    _studentClassLabel.textAlignment = NSTextAlignmentCenter;
    _studentClassLabel.font = [UIFont systemFontOfSize:12];
    _studentClassLabel.textColor = B_color(153, 153, 153);
    _studentClassLabel.text = self.model.class_name;
    [view addSubview:_studentClassLabel];
    [_studentClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(_studentNameLabel.mas_bottom).with.offset(1);
        make.height.mas_equalTo(17);
    }];
    
    [self addTitleView:view];
    
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    customView.backgroundColor = [UIColor clearColor];
    
    _teacherAvatar = [[UIImageView alloc]init];
    [customView addSubview:_teacherAvatar];
    _teacherAvatar.backgroundColor = [UIColor clearColor];
    _teacherAvatar.layer.cornerRadius = 15;
    _teacherAvatar.layer.masksToBounds = YES;
    if ([self.model.teacher_gender isEqualToString:@"female"]) {
        [_teacherAvatar sd_setImageWithURL:[NSURL URLWithString:self.model.teacher_avatar] placeholderImage:[UIImage imageNamed:@"teacher_female"]];
    }else{
        [_teacherAvatar sd_setImageWithURL:[NSURL URLWithString:self.model.teacher_avatar] placeholderImage:[UIImage imageNamed:@"teacher_male"]];
    }
    [_teacherAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(customView);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _teacherName = [[UILabel alloc]init];
    _teacherName.textAlignment = NSTextAlignmentCenter;
    _teacherName.font = [UIFont systemFontOfSize:12];
    _teacherName.textColor = B_color(102, 102, 102);
    _teacherName.text = self.model.teacher_name;
    [customView addSubview:_teacherName];
    [_teacherName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(_teacherAvatar.mas_bottom).with.offset(3);
        make.height.mas_equalTo(13);
    }];
    
    [self addRightViewWithCustomView:customView];
}
#pragma mark -action-
- (void)refreshData{
    NSLog(@"刷新");
    _reftype = refreshData;
    [self getMessageInfoListWithOffset:@0 Limit:Limit_count];
}
- (void)upLoadData{
    NSLog(@"加载");
    _reftype = uploadData;
    [self.tableView.mj_footer beginRefreshing];
    [self getMessageInfoListWithOffset:[NSNumber numberWithInteger:_messageOriginListData.count] Limit:Limit_count];
}
- (void)getMessageInfoListWithOffset:(NSNumber *)offset Limit:(NSNumber *)limit_count{
    
    BGetMessageInfoList *action = [[BGetMessageInfoList alloc]initWithOffset:offset Limit:limit_count WithUUID:self.model.uuid];
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
        if (result.get_error_code == kServerErrorCode_OK) {
            
            NSArray *array = [result try_get_data_with_array];
            if (_reftype == refreshData) {
                _messageListData = [NSMutableArray array];
                _messageOriginListData = [NSMutableArray array];
            }
            [array bk_each:^(id obj) {
                BMessageInfo *info = [[BMessageInfo alloc]initWithDictionary:obj error:nil];
                [_messageOriginListData addObject:info];
            }];
            
            [self dealMessageListData];
            if (_messageListData.count) {
                self.tableView.hidden = NO;
                self.bg_view.hidden = YES;
            }else{
                self.tableView.hidden = YES;
                self.bg_view.hidden = NO;
            }
            
            [_tableView reloadData];
        }else{
            [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_footer setValue:@"" forKeyPath:@"stateLabel.text"];
    } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
        
    }];
}
- (void)setMessageReaded:(NSString *)messageUuid_id{
    BReadMessage *action = [[BReadMessage alloc]initWithMessage_ID:messageUuid_id];
    [BUntil showHUDAddedTo:self.view];
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        [BUntil hideAllHUDsForView:self.view];
        BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
        
        if (result.get_error_code == kServerErrorCode_OK) {
            [self refreshData];
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
            cell.hasUnReadMessage = [self checkArray:array];
        cell.selected = NO;
        return cell;
        }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = _messageListData[indexPath.section];
    BMessageInfo  *info = array[indexPath.row];
    
    BMessageDetailViewController *detail  =  [[BMessageDetailViewController alloc]initWithNib];
    detail.webUrl = info.message_detail_url;
    [self.navigationController pushViewController:detail animated:YES];

//    [self setMessageReaded:info.messageUuid_id];
    NSLog(@"info %@",info);
}
#pragma mark UIScrollView
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    _img_shadowView.hidden = NO;
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    _img_shadowView.hidden = YES;
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y>0){
        _img_shadowView.hidden = NO;
    }else{
        _img_shadowView.hidden = YES;
        
    }
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

- (BOOL)checkArray:(NSArray *)array{
    for (int i  = 1; i<array.count; i++) {
        id obj = array[i];
        if ([obj isKindOfClass:[BMessageInfo class]]) {
            BMessageInfo *info = (BMessageInfo *)obj;
            if ([info.messageUuid_status isEqualToString:@"unread"]) {
                return YES;
                break;
            }
        }
    }
    return NO;
}
- (void)dealMessageListData{
    NSMutableArray *muarray = [NSMutableArray array];
    
    NSMutableArray *timeArr = [NSMutableArray array];
    for (int i = 0; i<_messageOriginListData.count; i++) {
        NSUInteger index;
        BMessageInfo *info = _messageOriginListData[i];
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
        for (BMessageInfo *info in _messageOriginListData) {
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
