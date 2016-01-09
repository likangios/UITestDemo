//
//  BForgetPasswordViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BForgetPasswordViewController.h"

@interface BForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getConfirmCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation BForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addBackItem];
    self.barTitle = @"忘记密码";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)OkBtnClick:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getConfirmCodeBtnClick:(id)sender {

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
