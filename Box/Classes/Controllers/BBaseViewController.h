//
//  BBaseViewController.h
//  Box
//
//  Created by FengLing on 15/12/9.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCustonNavBar.h"
#import "BBaseCell.h"
#import "BCustomRefresh.h"
#import "BCustomFoot.h"
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
/**
 *  右边按钮事件
 *
 *  @param sender
 */
- (void)rightAction:(id)sender;

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
/**
 *  添加右边ItemView  默认图片  高亮图片
 */
- (void)addRightViewWithImage:(UIImage *)img hightImage:(UIImage *)himg;
/**
 *  添加左边ItemView  默认图片  高亮图片
 */
- (void)addLeftViewWithImage:(UIImage *)img hightImage:(UIImage *)himg;
/**
 *  添加右边ItemView  title
 */
- (void)addRightViewWithTitle:(NSString *)title;
/**
 *  添加右边ItemView  自定义view
 */
- (void)addRightViewWithCustomView:(UIView *)view;

@end
