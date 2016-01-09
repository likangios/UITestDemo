//
//  BModifyPasswordViewController.m
//  Box
//
//  Created by 哈哈哈 on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BModifyPasswordViewController.h"

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
    [self.navigationController popViewControllerAnimated:YES];
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
