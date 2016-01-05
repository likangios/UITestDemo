//
//  BActionFindPWD.h
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BActionBase.h"
/**
 找回密码
 */
@interface BActionFindPWD : BActionPostBase
/**
 *  找回密码
 *
 *  @param phone_number 手机号
 *  @param password     新密码
 *  @param confirm_code 验证码
 *
 */
-(id) initWithPhoneNumber:(NSString *) phone_number
                 Password:(NSString *) password
              ConfirmCode:(NSString *) confirm_code;
@end
