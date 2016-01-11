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


#define COUNTDOWNTIME 60


@interface BRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getConfirmCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic,strong) NSTimer *timerForsms;
@end

@implementation BRegisterViewController
int seconds;

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
    if ([self checkBeforRegister]) {
        
    }
}
- (IBAction)zhijiLogin:(id)sender {
    
    [self.navigationController pushViewController:[[BLoginViewController alloc]initWithNib] animated:YES];
}
- (IBAction)getConfirmCodeBtnClick:(id)sender {
    if ([BUntil checkPhoneNumInput:self.phoneTextField.text]) {
        [BUntil showHUDAddedTo:self.view];
        BConfirmCodeAction *action = [[BConfirmCodeAction alloc]initWithPhoneNumber:self.phoneTextField.text];
        [action DoActionWithSuccess:^(BActionBase *action, id responseObject, AFHTTPRequestOperation *operation) {
            [BUntil hideAllHUDsForView:self.view];
            [self performTimer];
        } Failure:^(BActionBase *action, NSError *error, AFHTTPRequestOperation *operation) {
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
    }
    seconds = COUNTDOWNTIME;
    _timerForsms = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(decreaseSmsCodefromNumber:) userInfo:nil repeats:YES];
}

- (void)decreaseSmsCodefromNumber:(NSTimer *)timer
{
    if (seconds > 0) {
        [self.getConfirmCodeBtn setTitle:[NSString stringWithFormat:@"%ds后重新获取", seconds] forState:UIControlStateNormal];
        [self.getConfirmCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        --seconds;
        
    } else {
        [self.getConfirmCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getConfirmCodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [[self.getConfirmCodeBtn titleLabel] setTextAlignment:NSTextAlignmentCenter];
        self.getConfirmCodeBtn.enabled = YES;
        [[self.getConfirmCodeBtn titleLabel] setTextColor:[UIColor redColor]];
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
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入正确手机号"];
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
