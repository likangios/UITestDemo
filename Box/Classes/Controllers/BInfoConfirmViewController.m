//
//  BInfoConfirmViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/7.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BInfoConfirmViewController.h"
#import "BAddUIDIRelation.h"
#import "BGetUUIDInfoAction.h"
@interface BInfoConfirmViewController ()

@property (nonatomic,strong) IBOutlet UILabel *studentName;

@property (nonatomic,strong) IBOutlet UILabel *studentAge;

@property (nonatomic,strong) IBOutlet UILabel *studentSchool;

@property (nonatomic,strong) IBOutlet UILabel *studentClass;

@property (nonatomic,strong) IBOutlet UILabel *studentLearnTime;

@property (nonatomic,strong) IBOutlet UIButton *confirmBtn;

@end

@implementation BInfoConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addBackItem];
    [self updataUI];
    self.barTitle = @"信息确认";
    [self getInfoWithUUID:self.uuid];
}
-(void)updataUI{
    if (self.model) {
    self.studentName.text = self.model.student_name;
    self.studentAge.text = [NSString stringWithFormat:@"年龄：%d岁",self.model.student_age.intValue];
    self.studentSchool.text = self.model.organization_name;
    self.studentClass.text = [NSString stringWithFormat:@"班级：%@",self.model.class_name];
        self.studentLearnTime.text = [NSString stringWithFormat:@"入学时间：%@",self.model.admission_time];
    }
}
- (void)getInfoWithUUID:(NSString *)uuid{
    if (!uuid.length)
    return;
    BGetUUIDInfoAction *action = [[BGetUUIDInfoAction alloc]initWithUUID:uuid];
    [BUntil showHUDAddedTo:self.view];
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        [BUntil hideAllHUDsForView:self.view];
        BResponeResult *result=  [BResponeResult createWithResponeObject:responseObject];
        if (result.get_error_code == kServerErrorCode_OK) {
            self.model = [[BObjectFactory shared] createWithClassType:@"BUUIDinfoModel" JsonDirectory:[result get_first_object]];
            [self updataUI];
        }else{
            [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
        }
    } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
        [BUntil hideAllHUDsForView:self.view];
    }];
}
-(IBAction)confirmClick:(id)sender{
    
    BAddUIDIRelation *action = [[BAddUIDIRelation alloc]initWithUUID:self.model.uuid];
    [BUntil showHUDAddedTo:self.view];
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
        [BUntil hideAllHUDsForView:self.view];
        if (result.get_error_code == kServerErrorCode_OK) {
            [[NSNotificationCenter defaultCenter] postNotificationName:KADDUUIDNOTIFICATION object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [BUntil showErrorHUDViewAtView:self.view WithTitle:result.get_messge];
        }
    } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
        [BUntil hideAllHUDsForView:self.view];
    }];

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
