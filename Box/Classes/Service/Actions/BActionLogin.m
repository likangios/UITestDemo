//
//  BActionLogin.m
//  Box
//
//  Created by FengLing on 15/12/30.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "BActionLogin.h"

@implementation BActionLogin

-(id) initWithPhoneNumber:(NSString *) phone_number
                 Password:(NSString *) password
{
    self = [super initWithActionURLString:@"/api/v1/user/parent/login.json"];
    if( self )
    {
        if( [phone_number length]  > 0 && [password length] > 0 )
        {
            self.parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                               phone_number , @"phone_num" ,
                               password , @"password",
                               nil];
        }
    }
    self.isValid = YES;
    
    return self;
}

@end
