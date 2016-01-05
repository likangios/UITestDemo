//
//  BBaseViewController.h
//  Box
//
//  Created by FengLing on 15/12/9.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBaseViewController : UIViewController

- (instancetype)initWithNib;

- (void)backAction:(id)sender;

- (void)dismissAction:(id)sender;

- (void)addCustomNavBar;

- (void)addBackItem;

- (void)addRedBackItem;

@end
