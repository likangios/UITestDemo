//
//  BUpdateToken.m
//  Box
//
//  Created by 哈哈哈 on 16/1/20.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BUpdateToken.h"

@implementation BUpdateToken
- (instancetype)initWithToken:(NSString *)token{
    self = [super initWithActionURLString:@"/api/v1/user/sign/updateDeviceToken.json"];
    if (self) {
        self.parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:token,@"device_token", @"iphone",@"device_type",nil];
    }
    self.isValid = YES;
    return self;
}
@end
