//
//  BCustomAlertView.m
//  Box
//
//  Created by 哈哈哈 on 16/2/18.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BCustomAlertView.h"

@interface BCustomAlertView ()

@end

@implementation BCustomAlertView

- (IBAction)LeftBtnClick:(id)sender{
    if (_leftBlocks) {
        _leftBlocks();
    }
    [self removeFromSuperview];
}

- (IBAction)RightBtnClick:(id)sender{
    [self removeFromSuperview];
    if (_rightBlocks) {
        _rightBlocks();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
