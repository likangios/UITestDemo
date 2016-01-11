//
//  BConfirmCodeAction.h
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BActionBase.h"
/**
 *  请求验证码
 */
@interface BConfirmCodeAction : BActionPostBase
/**
 *  请求短信验证码
 *
 *  @param phone_number 手机号
 *  @param template_id  注册 1  找回密码 2
 *
 *  @return <#return value description#>
 */
-(id) initWithPhoneNumber:(NSString *) phone_number andTemplate_id:(NSString *)template_id;

@end
