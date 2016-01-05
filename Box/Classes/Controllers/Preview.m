//
//  Preview.m
//  Box
//
//  Created by FengLing on 16/1/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "Preview.h"

@interface Preview ()

@property (nonatomic,strong) IBOutlet UIView *box_view;

@property (nonatomic,strong) IBOutlet UIView *scan_line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Top;
//@property (nonatomic,strong) NSThread *thread;
@end

@implementation Preview

- (void)awakeFromNib{
    [super awakeFromNib];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timer_callback) userInfo:nil repeats:YES];

}
//- (void)newThread
//{
//    @autoreleasepool
//    {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timer_callback) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] run];
//    }
//}
- (void)timer_callback{
    
    if (self.Top.constant == self.box_view.frame.size.height) {
        self.Top.constant = 0;
    }else{
        self.Top.constant ++;
    }
}
- (void)removeFromSuperview{
    [super removeFromSuperview];
    if (_timer.isValid) {
        [_timer invalidate];
    }
    _timer = nil;
}

@end
