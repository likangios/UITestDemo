//
//  BRegisterViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/2.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BRegisterViewController.h"
#import "BLoginViewController.h"
#import "BSignupWithPhoneAction.h"
#import "BConfirmCodeAction.h"
#import "AppDelegate.h"

@interface BRegisterViewController ()
{
    int seconds;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getConfirmCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic,strong) IBOutlet UIButton *isShowPwd;

@property (nonatomic,strong) NSTimer *timerForsms;
@end

@implementation BRegisterViewController

- (IBAction)ShowPwdClick:(id)sender{
    _isShowPwd.selected = !_isShowPwd.selected;
    _passwordTextField.secureTextEntry = !_isShowPwd.selected;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addBackItem];
    self.barTitle = @"新用户";
}
#pragma mark private 

#pragma mark action

- (IBAction)registerBtnClick:(id)sender {
    DDLogError(@"注册");
    if ([self checkBeforRegister]) {
        BSignupWithPhoneAction *action = [[BSignupWithPhoneAction alloc]initWithPhoneNumber:self.phoneTextField.text ConfirmCode:self.confirmCodeTextField.text Password:self.passwordTextField.text];
        [BUntil showHUDAddedTo:self.view];
        [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];
            BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
            if (result.get_error_code == kServerErrorCode_OK) {
                
//                [self.navigationController pushViewController:[[BLoginViewController alloc]initWithNib] animated:YES];
                [(AppDelegate *)[UIApplication sharedApplication].delegate OnSignInSuccessful:self.phoneTextField.text WithPassword:self.passwordTextField.text];

            }else{
                [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
            }
        } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];
        }];
    }
}
- (IBAction)zhijiLogin:(id)sender {
    
    [self.navigationController pushViewController:[[BLoginViewController alloc]initWithNib] animated:YES];
}
- (IBAction)getConfirmCodeBtnClick:(id)sender {

    if ([BUntil checkPhoneNumInput:self.phoneTextField.text]) {
        [BUntil showHUDAddedTo:self.view];
        BConfirmCodeAction *action = [[BConfirmCodeAction alloc]initWithPhoneNumber:self.phoneTextField.text andTemplate_id:@"1"];
        [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];
            BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
            if (result.get_error_code == kServerErrorCode_OK) {
                [self performTimer];
            }else{
                [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
            }
        } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];

        }];
    }else{
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入正确手机号"];
    }
    DDLogError(@"获取验证码");
}

/**
 *    countdown timer
 *
 */

- (void)performTimer
{
    self.getConfirmCodeBtn.enabled = NO;
    
    if ([_timerForsms isValid]) {
        [_timerForsms invalidate];
        _timerForsms = nil;
    }
    seconds = COUNTDOWNTIME;
    _timerForsms = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(decreaseSmsCodefromNumber:) userInfo:nil repeats:YES];
}

- (void)decreaseSmsCodefromNumber:(NSTimer *)timer
{
    if (seconds > 0) {
        [self.getConfirmCodeBtn setTitle:[NSString stringWithFormat:@"%ds后重新获取", seconds] forState:UIControlStateNormal];
        --seconds;
        
    } else {
        [self.getConfirmCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getConfirmCodeBtn.enabled = YES;
        if ([_timerForsms isValid]) {
            [_timerForsms invalidate];
        }
    }
}
#pragma mark private 
- (BOOL)checkBeforRegister{
    if (![BUntil checkPhoneNumInput:self.phoneTextField.text]) {
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入正确手机号"];
        return NO;
    }else if (!self.confirmCodeTextField.text.length){
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入验证码"];
        return NO;
    }else if (self.passwordTextField.text.length<6){
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入至少6位密码"];
        return NO;
    }
    return YES;
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
