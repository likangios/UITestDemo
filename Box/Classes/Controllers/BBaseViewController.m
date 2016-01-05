//
//  BBaseViewController.m
//  Box
//
//  Created by FengLing on 15/12/9.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "BBaseViewController.h"
#import "UINavigationItem+BMargin.h"
#import "BCustonNavBar.h"
@interface BBaseViewController ()
{
    BCustonNavBar *_navBar;
}
@end

@implementation BBaseViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithNib{
    return [self initWithNibName:NSStringFromClass(self.class) bundle:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title  = (NSString *)NSStringFromClass([self class]);
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([UIDevice currentDevice].systemVersion) {
        
    }
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    self.navigationController.navigationBar.translucent = NO;
    }
}
- (void)addCustomNavBar{
    _navBar = [BCustonNavBar loadSelfWithNibOwner:self];
    [self.view addSubview:_navBar];
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(CustomNavigationBarHeight+20);
    }];
}

#pragma mark - layout
- (void)addBackItem{
    if (_navBar) {
    [_navBar addLeftBarButtonItem:[self getBackItem]];
    }
}
- (void)addRedBackItem{
    if (_navBar) {
    [_navBar addLeftBarButtonItem:[self getRedBackItem]];
    }
}
- (UIButton *)getBackItem{
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, CustomNavigationBarHeight)];
    [backBtn setImage:[UIImage imageNamed:@"icon_back_black_"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    return backBtn;
}
- (UIButton *)getRedBackItem{
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, CustomNavigationBarHeight)];
    [backBtn setImage:[UIImage imageNamed:@"img_logo_B_"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return backBtn;
}
/*
- (void)addBackItem{
    
    [self.navigationItem addLeftBarButtonItem:[self getBackItem]];
}
- (void)addRedBackItem{
    
    [self.navigationItem addLeftBarButtonItem:[self getRedBackItem]];
}
- (UIBarButtonItem *)getBackItem{
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"icon_back_black_"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    return backItem;
}
- (UIBarButtonItem *)getRedBackItem{
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"img_logo_B_"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    return backItem;
}
*/

- (void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dismissAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark  重新方法

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
