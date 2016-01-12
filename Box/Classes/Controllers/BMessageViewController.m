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

@interface BMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) IBOutlet UITableView *tableView;
@end

@implementation BMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addRedBackItem];
    [self initCell];
    self.barTitle = @"王宇飞";
    __weak typeof(self) _weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_weakself refreshData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [_weakself upLoadData];
    }];
}
#pragma mark -action-
- (void)refreshData{
    NSLog(@"刷新");
}
- (void)upLoadData{
    NSLog(@"加载");
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
