//
//  BWeChatFastLoginAction.m
//  Box
//
//  Created by FengLing on 16/1/15.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BWeChatFastLoginAction.h"

@implementation BWeChatFastLoginAction
-(id)initWithToken:(NSString *)token sign:(NSString *)sign
{
    
    NSString *string = [NSString stringWithFormat:@"/api/v1/weChat/weChatAppFastLogin.json"];
    self = [super initWithActionURLString:string];
    if (self) {
        self.parameters = [NSMutableDictionary dictionary];
        
        if (token) {
            
            [self.parameters setObject:token forKey:@"token"];
            
        }
        
        if (sign) {
            
            [self.parameters setObject:sign forKey:@"sign"];
            
        }
    }
    self.isValid = YES;
    return self;
}
@end
