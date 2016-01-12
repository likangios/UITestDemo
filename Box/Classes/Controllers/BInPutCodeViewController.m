//
//  BInPutCodeViewController.m
//  Box
//
//  Created by FengLing on 16/1/7.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BInPutCodeViewController.h"
#import "BInfoConfirmViewController.h"
#import "BGetUUIDInfoAction.h"
@interface BInPutCodeViewController ()

@property (nonatomic,strong) IBOutlet UITextField *courseCodeTextField;

@property (nonatomic,strong) IBOutlet UIButton *confirmCourseCodeBtn;

@end

@implementation BInPutCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addRedBackItem];
//    self.barTitle = @"输入课程码";
}
- (IBAction)confirmCourseCodeClick:(id)sender{
    
    if (self.courseCodeTextField.text.length) {
        BGetUUIDInfoAction *action = [[BGetUUIDInfoAction alloc]initWithUUID:self.courseCodeTextField.text];
        [BUntil showHUDAddedTo:self.view];
        [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];
            BResponeResult *result=  [BResponeResult createWithResponeObject:responseObject];
            if (result.get_error_code == kServerErrorCode_OK) {
                BUUIDinfoModel *model = [[BObjectFactory shared] createWithClassType:@"BUUIDinfoModel" JsonDirectory:[result get_first_object]];
                BInfoConfirmViewController *info = [[BInfoConfirmViewController alloc]initWithNib   ];
                info.model = model;
                [self.navigationController pushViewController:info animated:YES];
            }else{
                [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
            }
        } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
            [BUntil hideAllHUDsForView:self.view];
        }];
    }else{
        [BUntil showErrorHUDViewAtView:self.view WithTitle:@"输入正确的课程码"];
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
