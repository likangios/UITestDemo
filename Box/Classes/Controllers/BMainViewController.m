//
//  BMainViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/2.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BMainViewController.h"
#import "BQRCodeViewController.h"
#import "AppDelegate.h"
#import "UINavigationItem+BMargin.h"
#import "BMainCardCell.h"

@interface BMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) IBOutlet UITableView  *TableView;
@end

@implementation BMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addRightViewWithImage:[UIImage imageNamed:@"icon_set_black_"] hightImage:[UIImage imageNamed:@"icon_set_red_"]];
    [self addLeftViewWithImage:[UIImage imageNamed:@"icon_add_black_"] hightImage:[UIImage imageNamed:@"icon_add_red_"]];
    _TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNewData)];
    [_TableView.mj_header beginRefreshing];
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
    }
    return cell;
}
#pragma mark private 
- (void)initItem{
    UIButton *leftItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItemBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftItemBtn setImage:[UIImage imageNamed:@"icon_add_red_"] forState:UIControlStateNormal];
    [leftItemBtn setImage:[UIImage imageNamed:@"icon_add_black_"] forState:UIControlStateHighlighted];
    [leftItemBtn addTarget:self action:@selector(addCourse) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem addLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:leftItemBtn]];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
//    view.layer.borderColor = [UIColor redColor].CGColor;
//    view.layer.borderWidth = 1.0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(17, 0, 25, 25)];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.layer.cornerRadius = 12.5;
    imageView.layer.masksToBounds = YES;
    [view addSubview:imageView];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 27, 64, 17)];
    lab.text = @"张老师哈";
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font  =[UIFont systemFontOfSize:10];
    [view addSubview:lab];
    
    UIButton *rightItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightItemBtn setImage:[UIImage imageNamed:@"icon_set_red_"] forState:UIControlStateNormal];
    [rightItemBtn setImage:[UIImage imageNamed:@"icon_set_black_"] forState:UIControlStateHighlighted];
    [rightItemBtn addTarget:self action:@selector(setBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem addRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:view]];
}
#pragma mark action
- (void)setBtn{
    DDLogDebug(@"设置");
}
- (void)addCourse{
    DDLogDebug(@"添加");
    [self presentViewController:[[BQRCodeViewController alloc]initWithNib] animated:YES completion:NULL];
//    [self.navigationController pushViewController:[[BQRCodeViewController alloc]initWithNib] animated:YES];
}
- (void)reloadNewData{
    
    [self performSelector:@selector(endRef) withObject:nil afterDelay:2];
    
}
- (void)endRef{
    [_TableView.mj_header endRefreshing];
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
