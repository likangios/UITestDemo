//
//  BSignupWithPhoneAction.m
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BSignupWithPhoneAction.h"

@implementation BSignupWithPhoneAction
-(id) initWithPhoneNumber:(NSString *) phone_number
              ConfirmCode:(NSString *) confirm_code Password:(NSString *)pwd{
    self=[super initWithActionURLString:@"/api/v1/user/parent/register.json"];
    if (self) {
        
        self.parameters  = [[NSMutableDictionary alloc]initWithObjectsAndKeys:phone_number,@"phone_num",confirm_code,@"sms_code",pwd,@"password", nil];
    }
    self.isValid = YES;

    return self;
}
@end
