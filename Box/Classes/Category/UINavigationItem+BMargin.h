//
//  UINavigationItem+BMargin.h
//  Box
//
//  Created by FengLing on 16/1/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (BMargin)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;
- (void)addLeftBarButtonItems:(NSArray *)leftBarButtonItems;

@end
