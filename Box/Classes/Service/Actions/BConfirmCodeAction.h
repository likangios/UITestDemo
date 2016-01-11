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

-(id) initWithPhoneNumber:(NSString *) phone_number;

@end
