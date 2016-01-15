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
#import "BTestViewController.h"
#import "BInPutCodeViewController.h"
#import "BTestVC.h"
#import "BActionLogin.h"
#import "AppDelegate.h"
@interface BWelcomViewController ()
@property (nonatomic,strong) IBOutlet UIButton *loginBtn;
@property (nonatomic,strong) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrllowWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageviewWidth;
@property (nonatomic,strong) IBOutlet UIPageControl *pageControl;
@end

@implementation BWelcomViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _scrllowWidth.constant = ScreenWidth*3;
    _imageviewWidth.constant = ScreenWidth;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self Autologin];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)Autologin{
    NSString *acc  =  [BStoreService sharedStoreService].Account;
    NSString *pwd  =  [BStoreService sharedStoreService].Password;
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString *wxtoken = [defau stringForKey:WXFASTLOGINTOKEN];
    
    if (acc.length&&pwd.length){
        BActionLogin *action = [[BActionLogin alloc]initWithPhoneNumber:acc Password:pwd];
        [BUntil showHUDAddedTo:self.view];
        [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];
            
            BResponeResult *result=  [BResponeResult createWithResponeObject:responseObject];
            if (result.get_error_code ==kServerErrorCode_OK) {
                [(AppDelegate *)[UIApplication sharedApplication].delegate OnSignInSuccessful:acc WithPassword:pwd];
            }
            
        } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];
        }];
    }else if(wxtoken){
    [(AppDelegate *)[UIApplication sharedApplication].delegate wxFastLogin:wxtoken];
    }
        
}
#pragma mark --action--
- (IBAction)RegisterBtnClick:(id)sender {
    DDLogError(@"注册");
    [self.navigationController pushViewController:[[BRegisterViewController alloc]initWithNib] animated:YES];
}
- (IBAction)LoginBtnClick:(id)sender {
    DDLogError(@"登录");
    [self.navigationController pushViewController:[[BLoginViewController alloc]initWithNib] animated:YES];
}
#pragma mark private


#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrol.content %f",scrollView.contentOffset.x);
    _pageControl.currentPage = scrollView.contentOffset.x/ScreenWidth;
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
