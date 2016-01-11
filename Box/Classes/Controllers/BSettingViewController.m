//
//  BSettingViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/9.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BSettingViewController.h"
#import "BModifyPasswordViewController.h"
#import "BCourseCardCell.h"
#import "AppDelegate.h"

@interface BSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *courseListData;

@end

@implementation BSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addRedBackItem];
    self.barTitle = @"设置";
    _courseListData = [NSMutableArray array];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
- (void)initData{
    for (int i = 0; i<10; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",arc4random()%1000];
        [_courseListData addObject:str];
    }
    [_tableView reloadData];
}
#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _courseListData.count+4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger count = _courseListData.count;
    if (indexPath.row == 0) {
        return 25.0;
    }else if (indexPath.row == count+1){
        return 35.0;
    }else if (indexPath.row == count+2){
        return 65.0;
    }else if (indexPath.row == count+3){
        return 75.0;
    }
    return  [[self tableView:tableView cellForRowAtIndexPath:indexPath] getCellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger count = _courseListData.count;
    
    if (indexPath.row == 0) {
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courseSet"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"courseSet"];
            cell.textLabel.text = @"课程设置";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        }
        return cell;
        
    }else if (indexPath.row == count+1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountSet"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"accountSet"];
            cell.textLabel.text = @"账号设置";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        }
        return cell;
        
    }else if (indexPath.row == count+2){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"modifypassword"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"modifypassword"];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"修改登录密码" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
            [button addTarget:self action:@selector(modifyPassWordAction) forControlEvents:UIControlEventTouchUpInside];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.layer.cornerRadius = 5.0;
            button.layer.masksToBounds = YES;
            button.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor;
            button.layer.borderWidth = 2.0;
            [cell.contentView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.top.mas_equalTo(2.5);
                make.bottom.mas_equalTo(-2.5);
            }];
        }
        return cell;
    }else if (indexPath.row == count+3){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountSet"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"accountSet"];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor colorWithRed:255/255.0 green:16/255.0 blue:73/255.0 alpha:1]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.cornerRadius=  25.0;
            button.layer.masksToBounds = YES;
            [button setTitle:@"退出登录" forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            [button addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(35);
                make.right.mas_equalTo(-35);
                make.top.mas_equalTo(22.5);
                make.bottom.mas_equalTo(0);
            }];
        }
        return cell;
    }else{
        BCourseCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCourseCardCell"];
        if (cell == nil) {
            cell = [BCourseCardCell loadSelfWithNibOwner:self];
        }
        id mode = _courseListData[indexPath.row -1];
        
        [cell setDeleteCourseBlocks:^(NSIndexPath *indexPaht) {
            
            NSLog(@"delete index %ld",(long)indexPath.row);
        }];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    return view;
}
#pragma mark ---
#pragma mark action

- (void)modifyPassWordAction{
    DDLogDebug(@"修改密码");
    [self.navigationController pushViewController:[[BModifyPasswordViewController alloc]initWithNib] animated:YES];
}
- (void)loginOutAction{
[(AppDelegate *)[UIApplication sharedApplication].delegate OnSignoutSuccessful];
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