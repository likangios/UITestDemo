//
//  BBlureEffectView.m
//  Box
//
//  Created by 哈哈哈 on 16/1/9.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BBlureEffectView.h"

@interface BBlureEffectView ()

@property (nonatomic,strong) UIVisualEffectView *blurView;

@property (nonatomic,strong) UIBlurEffect *blur;


@end

@implementation BBlureEffectView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        _effectViewAlph = 1.0;
        _blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurView = [[UIVisualEffectView alloc]initWithEffect:_blur];
        _blurView.alpha = _effectViewAlph;
        _blurView.frame = frame;
        [self addSubview:_blurView];
    }
    return self;
}
- (void)setEffectStyle:(UIBlurEffectStyle)effectStyle{
    if (_blurView) {
        [_blurView removeFromSuperview];
    }
    _blur = [UIBlurEffect effectWithStyle:effectStyle];
    _blurView = [[UIVisualEffectView alloc]initWithEffect:_blur];
    _blurView.alpha = _effectViewAlph;
    [self addSubview:_blurView];
}
- (void)setEffectViewAlph:(CGFloat)effectViewAlph{
    _blurView.alpha = effectViewAlph;
}
- (void)addSubview:(UIView *)view{
    [super addSubview:view];
    [self sendSubviewToBack:_blurView];
}
@end
