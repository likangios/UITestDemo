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
              ConfirmCode:(NSString *) confirm_code{
    self=[super initWithActionURLString:@""];
    if (self) {
        
        self.parameters  = [[NSMutableDictionary alloc]initWithObjectsAndKeys:phone_number,@"phone_number",confirm_code,@"confirm_code", nil];
        
    }
    return self;
}
@end
