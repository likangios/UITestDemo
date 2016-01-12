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
#import "BWXApiRequestHandler.h"
#import "BWXApiManager.h"
#import "BActionLogin.h"
#import "AppDelegate.h"

@interface BLoginViewController ()<BWXApiManagerDelegate>
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
    self.barTitle = @"登录";
    NSString *acc  =  [BStoreService sharedStoreService].Account;
    if (acc.length) {
        self.phoneTextField.text = acc;
    }
    [BWXApiManager sharedManager].delegate = self;
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.phoneTextField.layer.borderColor = [UIColor redColor].CGColor;
    self.phoneTextField.layer.borderWidth = 2.0;
}
#pragma mark - aciton -
- (void)backAction:(id)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)loginBtnClick:(id)sender{
    DDLogError(@"登录");
    [self.view endEditing:YES];
    if ([self CheckPhoneAndPassword]) {
    BActionLogin *action = [[BActionLogin alloc]initWithPhoneNumber:self.phoneTextField.text Password:self.passwordTextField.text];
        [BUntil showHUDAddedTo:self.view];
        [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];

            BResponeResult *result=  [BResponeResult createWithResponeObject:responseObject];
            if (result.get_error_code ==kServerErrorCode_OK) {
//                BUserBaseModel *model = [[BUserBaseModel alloc]initWithDictionary:[result get_first_object] error:nil];
                [(AppDelegate *)[UIApplication sharedApplication].delegate OnSignInSuccessful:self.phoneTextField.text WithPassword:self.passwordTextField.text];
            }else{
                [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
            }
         
        } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
           
            [BUntil hideAllHUDsForView:self.view];
            
            
        }];

}
}
- (IBAction)wxloginBtnClick:(id)sender{
    DDLogError(@"微信登录");
[BWXApiRequestHandler sendAuthRequestScope:@"snsapi_userinfo" State:@"login" OpenID:@"" InViewController:self];
}
- (IBAction)forgetPasswordBtnClick:(id)sender{
        DDLogError(@"忘记密码");
    [self.navigationController pushViewController:[[BForgetPasswordViewController alloc]initWithNib] animated:YES];
}
- (IBAction)xinUserBtnClick:(id)sender{
        DDLogError(@"新用户");
    [self.navigationController pushViewController:[[BRegisterViewController alloc]initWithNib] animated:YES];
}
#pragma mark  -- AuthResponse -- 
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response{
    
    DDLogDebug(@"response -- %@",response.description);
}
#pragma mark UITextFieldDelegate 

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField == self.phoneTextField) {
        if (textField.text.length>13) {
        textField.text = [textField.text substringToIndex:13];
        }
    }
}
#pragma mark -- action 
- (BOOL)CheckPhoneAndPassword{
    if (![BUntil checkPhoneNumInput:self.phoneTextField.text]) {
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入正确手机号"];
        return NO;
    }else if (!self.passwordTextField.text.length){
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入密码"];
        return NO;
    }
    return YES;
}
#pragma mark 重写

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([BWXApiManager isWXAppInstalled]) {
        self.wxloginBtn.hidden = NO;
    }else{
        self.wxloginBtn.hidden = YES;
    }
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
