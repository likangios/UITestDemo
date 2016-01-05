//
//  BQRAlertView.h
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BQRAlertView : UIView
/**
 *  预览 拍照 相册 AlertView
 *
 *  @param showview 要显示在的view
 *  @param priview  预览回调
 *  @param camera   拍照回调
 *  @param album    相册回调
 */
+ (void)showViewAt:(UIView *)showview Action1:(void(^)())ac1 Action2:(void (^)())ac2;
@end
