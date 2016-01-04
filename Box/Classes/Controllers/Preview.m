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
@end

@implementation Preview

- (void)awakeFromNib{
    [super awakeFromNib];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(move) userInfo:nil repeats:YES];
}
- (void)move{
    
    if (self.Top.constant == self.box_view.frame.size.height) {
        self.Top.constant = 0;
    }else{
        self.Top.constant ++;
    }
}
@end
