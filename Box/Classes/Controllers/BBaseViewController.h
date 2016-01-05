//
//  BBaseViewController.h
//  Box
//
//  Created by FengLing on 15/12/9.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCustonNavBar.h"

@interface BBaseViewController : UIViewController
{
    BCustonNavBar *_navBar;
}
@property (nonatomic,strong) NSString *barTitle;
@property (nonatomic,strong) UIImage *barImage;

/**
 *  从xib初始化
 *
 *  @return
 */
- (instancetype)initWithNib;
/**
 *  返回按钮事件
 *
 *  @param sender
 */
- (void)backAction:(id)sender;

- (void)dismissAction:(id)sender;

/**
 *  添加自定义导航栏
 */
- (void)addCustomNavBar;


/**
 *  添加普通返回按钮
 */
- (void)addBackItem;
/**
 *  添加左边红色返回按钮
 */
- (void)addRedBackItem;
/**
 *  添加中间视图
 */
- (void)addTitleView:(UIView *)titView;

- (void)addRightViewWithImage:(UIImage *)img;

- (void)addRightViewWithTitle:(NSString *)title;

- (void)addRightViewWithCustomView:(UIView *)view;

@end
