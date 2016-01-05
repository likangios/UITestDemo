//
//  BCustonNavBar.m
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BCustonNavBar.h"

@implementation BCustonNavBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)addLeftBarButtonItem:(UIView *)leftItem{
    [self addSubview:leftItem];
    [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(CGRectGetWidth(leftItem.frame));
    }];
}
- (void)addRightBarButtonItem:(UIView *)rightItem{
    [rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(CGRectGetWidth(rightItem.frame));
    }];
}
@end
