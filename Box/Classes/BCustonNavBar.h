//
//  BCustonNavBar.h
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  自定义导航栏
 */
@interface BCustonNavBar : UIView
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UIView *centerView;

@property (nonatomic,strong) NSString *barTitle;
@property (nonatomic,strong) UIImage *barImage;

/**
 *  添加左边视图
 *
 *  @param leftItem
 */
- (void)addLeftBarButtonItem:(UIView *)leftItem;
/**
 *  添加右边视图
 *
 *  @param leftItem
 */
- (void)addRightBarButtonItem:(UIView *)rightItem;
/**
 *  添加中间视图
 *
 *  @param leftItem
 */
- (void)addTitleView:(UIView *)titleView;
@end
