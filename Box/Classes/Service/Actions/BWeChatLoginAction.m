//
//  BWeChatLoginAction.m
//  Box
//
//  Created by FengLing on 16/1/15.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BWeChatLoginAction.h"

@implementation BWeChatLoginAction
-(id)initWithCode:(NSString *)code sign:(NSString *)sign
{
    
    NSString *string = [NSString stringWithFormat:@"/api/v1/weChat/weChatAppLogin.json"];
    self = [super initWithActionURLString:string];
    if (self) {
        self.parameters = [NSMutableDictionary dictionary];
        
        if (code) {
            
            [self.parameters setObject:code forKey:@"code"];
            
        }
        
        if (sign) {
            
            [self.parameters setObject:sign forKey:@"sign"];
            
        }
    }
    self.isValid = YES;
    return self;
}
@end
