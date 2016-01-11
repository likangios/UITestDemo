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
    if (enabled) {
        self.alpha = 1;
    }else{
        self.alpha = 0.6;
    }
}
@end
