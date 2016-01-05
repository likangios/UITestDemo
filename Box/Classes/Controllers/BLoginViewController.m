//
//  BLoginViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/2.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BLoginViewController.h"
#import "BRegisterViewController.h"
#import "BForgetPasswordViewController.h"
#import "BMainViewController.h"

@interface BLoginViewController ()
@property (nonatomic,strong) IBOutlet UITextField *phoneTextField;
@property (nonatomic,strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic,strong) IBOutlet UIButton *loginBtn;
@property (nonatomic,strong) IBOutlet UIButton *wxloginBtn;
@property (nonatomic,strong) IBOutlet UIButton *forgetPasswordBtn;
@property (nonatomic,strong) IBOutlet UIButton *xinUserBtn;
@end

@implementation BLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addBackItem];
    [self addRightViewWithImage:[UIImage imageNamed:@"icon_add_black_"]];
    self.barTitle = @"login";
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.phoneTextField.layer.borderColor = [UIColor redColor].CGColor;
    self.phoneTextField.layer.borderWidth = 2.0;
}
#pragma mark - aciton -
- (IBAction)loginBtnClick:(id)sender{
    DDLogError(@"登录");
    [self.navigationController pushViewController:[[BMainViewController alloc]initWithNib] animated:YES];
}
- (IBAction)wxloginBtnClick:(id)sender{
    DDLogError(@"微信登录");
}
- (IBAction)forgetPasswordBtnClick:(id)sender{
        DDLogError(@"忘记密码");
    [self.navigationController pushViewController:[[BForgetPasswordViewController alloc]initWithNib] animated:YES];
}
- (IBAction)xinUserBtnClick:(id)sender{
        DDLogError(@"新用户");
    [self.navigationController pushViewController:[[BRegisterViewController alloc]initWithNib] animated:YES];
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
