//
//  BActionLogin.h
//  Box
//
//  Created by FengLing on 15/12/30.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "BActionBase.h"
/**
 登陆请求
 */
@interface BActionLogin : BActionPostBase
/**
 *  new 并且初始化对象
 *
 *  @param phone_number 电话号码
 *  @param password     密码
 *  @param nickname     昵称
 *  @param confirm_code 验证码
 *  @param upload_image 上传的头像图片
 *
 *  @return 返回对象，有效与否看 IsValid 属性
 */
-(id) initWithPhoneNumber:(NSString *) phone_number
                 Password:(NSString *) password;
@end
