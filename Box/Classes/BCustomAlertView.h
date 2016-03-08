//
//  BCustomAlertView.h
//  Box
//
//  Created by 哈哈哈 on 16/2/18.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCustomAlertView : UIView

@property (nonatomic,strong) IBOutlet UILabel *contentLabel;

@property (nonatomic,strong) IBOutlet UIButton *leftBtn;

@property (nonatomic,strong) IBOutlet UIButton *rightBtn;

@property (nonatomic,copy) void (^leftBlocks)();

@property (nonatomic,copy) void (^rightBlocks)();

@end
