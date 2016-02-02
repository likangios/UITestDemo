//
//  BCustomFoot.m
//  Box
//
//  Created by FengLing on 16/2/2.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BCustomFoot.h"

@implementation BCustomFoot

- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"update_%zd", i]];
        [refreshingImages addObject:image];
    }
    self.refreshingTitleHidden = YES;
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
@end
