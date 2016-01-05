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
    if (_leftView) [_leftView removeFromSuperview];
    _leftView = leftItem;
    [self addSubview:leftItem];
    [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(CGRectGetWidth(leftItem.frame));
    }];
}
- (void)addRightBarButtonItem:(UIView *)rightItem{
    if (_rightView) [_rightView removeFromSuperview];
    _rightView = rightItem;
    [self addSubview:_rightView];
    [rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(CGRectGetWidth(rightItem.frame));
    }];
}
- (void)addTitleView:(UIView *)titleView{
    if (_centerView) [_centerView removeFromSuperview];
    _centerView =titleView;
    [self addSubview:_centerView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(CGRectGetWidth(titleView.frame));
        make.height.mas_equalTo(CGRectGetHeight(titleView.frame));
    }];
}
- (void)setBarImage:(UIImage *)barImage{
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, barImage.size.width, CustomNavigationBarHeight)];
    imageview.image = barImage;
    [self addTitleView:imageview];
}
- (void)setBarTitle:(NSString *)barTitle{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, CustomNavigationBarHeight)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = barTitle;
    label.textColor = [UIColor blackColor];
    [self addTitleView:label];
}
@end
