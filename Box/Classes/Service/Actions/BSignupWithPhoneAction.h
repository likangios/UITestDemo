//
//  BSignupWithPhoneAction.h
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BActionBase.h"
/**
 注册
 */
@interface BSignupWithPhoneAction : BActionPostBase
/**
 *  注册
 *
 *  @param phone_number 手机号
 *  @param confirm_code 验证码
 *
 *  @return
 */
-(id) initWithPhoneNumber:(NSString *) phone_number
              ConfirmCode:(NSString *) confirm_code Password:(NSString *)pwd;

@end
