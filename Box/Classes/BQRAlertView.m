//
//  BQRAlertView.m
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BQRAlertView.h"

typedef void(^blocks)();

@interface BQRAlertView ()
{
    blocks _ac1Block;
    blocks _ac2Block;
}
@end

@implementation BQRAlertView

- (instancetype)initWithShowView:(UIView *)view  Action1:(void(^)())ac1 Action2:(void (^)())ac2{
    self = [super initWithFrame:view.frame];
    if (self) {
        self.effectViewAlph = 0.8;
        
        _ac1Block = ac1;
        _ac2Block = ac2;
        
        [view addSubview:self];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        CGFloat width = 275;
        
        CGFloat height = 181;
        
        UIView *v = [[UIView alloc]init];
        
        v.layer.cornerRadius = 5.0;
        v.layer.masksToBounds = YES;
        v.bounds = CGRectMake(0, 0, width,height);
        
        v.center = CGPointMake(CGRectGetWidth(view.frame)/2.0, CGRectGetHeight(view.frame)/2.0);
        
        v.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:v];
        
        NSArray *arr = @[@"扫描二维码",@"输入课程码"];
        NSArray *imgs = @[@"icon_scan_black_",@"icon_text_black_"];
        NSArray *HighlightImgs = @[@"icon_scan_red_",@"icon_text_red_"];
        
        CGFloat btnW = height/arr.count;
        
        for (int i = 0; i<arr.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0,btnW*i, width, btnW);
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:HighlightImgs[i]] forState:UIControlStateHighlighted];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            btn.tag = i+1;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [btn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.87] forState:UIControlStateNormal];
            [btn setTitleColor:color_red forState:UIControlStateHighlighted];

            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [v addSubview:btn];
            if (i>0) {
                UIView *l = [[UIView alloc]initWithFrame:CGRectMake(0,i*btnW, width, 0.5)];
                l.backgroundColor = [UIColor grayColor];
                [v addSubview:l];
            }
        }
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideself];
}
- (void)btnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
        {
            NSLog(@"拍照");
            if (_ac1Block) {
                _ac1Block();
            }
        }
            break;
        case 2:
        {
            NSLog(@"相册");
            if (_ac2Block) {
                _ac2Block();
            }
        }
            break;
        default:
            break;
    }
    [self hideself];
}
- (void)hideself{
    
    [self removeFromSuperview];
}
+ (void)showViewAt:(UIView *)showview Action1:(void(^)())ac1 Action2:(void (^)())ac2{
    BQRAlertView *v = [[BQRAlertView alloc]initWithShowView:showview  Action1:ac1 Action2:ac2];
    [showview addSubview:v];
}
@end
