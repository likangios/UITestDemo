//
//  BInfoConfirmViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/7.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BInfoConfirmViewController.h"

@interface BInfoConfirmViewController ()

@property (nonatomic,strong) IBOutlet UILabel *studentName;

@property (nonatomic,strong) IBOutlet UILabel *studentAge;

@property (nonatomic,strong) IBOutlet UILabel *studentSchool;

@property (nonatomic,strong) IBOutlet UILabel *studentClass;

@property (nonatomic,strong) IBOutlet UILabel *studentLearnTime;
@end

@implementation BInfoConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomNavBar];
    [self addBackItem];
    self.barTitle = @"信息确认";
    // Do any additional setup after loading the view from its nib.
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
