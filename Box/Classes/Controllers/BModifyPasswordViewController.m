//
//  BModifyPasswordViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BModifyPasswordViewController.h"
#import "BChangePasswordAction.h"
@interface BModifyPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *NewpasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *OldpasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *OkBtn;

@end

@implementation BModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addBackItem];
    self.barTitle = @"修改密码";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)OkBtnClick:(id)sender {
    if ([self checkPassword]) {
        BChangePasswordAction *action = [[BChangePasswordAction alloc]initWithOldPwd:self.OldpasswordTextField.text AndNewPwd:self.NewpasswordTextField.text];
        [BUntil showHUDAddedTo:self.view];
        [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
            BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
            [BUntil hideAllHUDsForView:self.view];
            if (result.get_error_code == kServerErrorCode_OK) {
                [[BStoreService sharedStoreService] updtePassword:self.NewpasswordTextField.text];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
            }
        } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];
        }];
    }
}
- (BOOL)checkPassword{
    if (!self.OldpasswordTextField.text.length) {
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入旧密码"];
        return NO;
    }
    if (self.NewpasswordTextField.text.length<6) {
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入至少6位新密码"];
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
