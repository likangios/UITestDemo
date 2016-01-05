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
        _ac1Block = ac1;
        _ac2Block = ac2;
        
        [view addSubview:self];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        CGFloat width = 292;
        
        CGFloat height = 98;
        
        UIView *v = [[UIView alloc]init];
        
        v.layer.cornerRadius = 2.0;
        v.layer.masksToBounds = YES;
        v.bounds = CGRectMake(0, 0, width,height);
        
        v.center = CGPointMake(CGRectGetWidth(view.frame)/2.0, CGRectGetHeight(view.frame)/2.0);
        
        v.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:v];
        
        NSArray *arr = @[@"ac1",@"ac2"];
        
        CGFloat btnW = height/arr.count;
        
        for (int i = 0; i<arr.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(21,btnW*i, width-42, btnW);
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            btn.tag = i+1;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.87] forState:UIControlStateNormal];
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
