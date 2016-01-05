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
    self  = [super initWithActionURLString:@"users/findpwd/phone.json"];
    if (self) {
        self.parameters = [NSMutableDictionary dictionary];
        if (phone_number) {
            [self.parameters setObject:phone_number forKey:@"phone_num"];
        }
        if (password) {
            [self.parameters setObject:password forKey:@"pwd"];
        }
        if (confirm_code) {
            [self.parameters setObject:confirm_code forKey:@"token"];
        }
    }
    self.isValid = YES;
    return self;
}
@end
