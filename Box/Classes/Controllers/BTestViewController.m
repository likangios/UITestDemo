//
//  BTestViewController.m
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BTestViewController.h"
#import "BQRAlertView.h"
@implementation BTestViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [BQRAlertView showViewAt:self.view.window Action1:^{
    
    } Action2:^{
        
    }];
}
@end
