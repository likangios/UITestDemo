//
//  BRegisterViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/2.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BRegisterViewController.h"
#import "BLoginViewController.h"

@interface BRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getConfirmCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation BRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addBackItem];
    self.barTitle = @"新用户";
    // Do any additional setup after loading the view from its nib.
}
#pragma mark private 

#pragma mark action

- (IBAction)registerBtnClick:(id)sender {
    DDLogError(@"注册");
}
- (IBAction)zhijiLogin:(id)sender {
    
    [self.navigationController pushViewController:[[BLoginViewController alloc]initWithNib] animated:YES];
}
- (IBAction)getConfirmCodeBtnClick:(id)sender {
    DDLogError(@"获取验证码");
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
