//
//  BCustomButton.m
//  Box
//
//  Created by FengLing on 16/1/11.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BCustomButton.h"

@implementation BCustomButton

-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    if (enabled) {
        self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:1.0];
    }else{
        self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0.5];
    }
}
@end
