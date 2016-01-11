//
//  BChangePasswordAction.m
//  Box
//
//  Created by 哈哈哈 on 16/1/11.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BChangePasswordAction.h"

@implementation BChangePasswordAction

- (id)initWithOldPwd:(NSString *)oldPWD AndNewPwd:(NSString *)newpwd{
    self = [super initWithActionURLString:@""];
    if (self) {
        
        self.parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:oldPWD,@"old_password",newpwd,@"new_password", nil];
    }
    self.isValid = YES;
    return self;
}
@end
