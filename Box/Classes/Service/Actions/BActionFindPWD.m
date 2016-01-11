//
//  BActionFindPWD.m
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BActionFindPWD.h"

@implementation BActionFindPWD
-(id) initWithPhoneNumber:(NSString *) phone_number
                 Password:(NSString *) password
              ConfirmCode:(NSString *) confirm_code{
    self  = [super initWithActionURLString:@"/api/v1/user/parent/findPassword.json"];
    if (self) {
        self.parameters = [NSMutableDictionary dictionary];
        if (phone_number) {
            [self.parameters setObject:phone_number forKey:@"phone_num"];
        }
        if (password) {
            [self.parameters setObject:password forKey:@"password"];
        }
        if (confirm_code) {
            [self.parameters setObject:confirm_code forKey:@"sms_code"];
        }
    }
    self.isValid = YES;
    return self;
}
@end
