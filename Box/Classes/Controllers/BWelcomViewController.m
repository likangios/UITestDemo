//
//  BWelcomViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/2.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BWelcomViewController.h"
#import "BLoginViewController.h"
#import "BRegisterViewController.h"
#import "BQRCodeViewController.h"
@interface BWelcomViewController ()

@end

@implementation BWelcomViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.layer.cornerRadius
    // Do any additional setup after loading the view from its nib.
}
#pragma mark --action--
- (IBAction)RegisterBtnClick:(id)sender {
    DDLogError(@"注册");
    [self.navigationController pushViewController:[[BRegisterViewController alloc]initWithNib] animated:YES];

}
- (IBAction)LoginBtnClick:(id)sender {
    DDLogError(@"登录");
    [self.navigationController pushViewController:[[BQRCodeViewController alloc]initWithNib] animated:YES];
}
#pragma mark private


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
