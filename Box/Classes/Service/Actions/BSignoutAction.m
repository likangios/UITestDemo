//
//  BSignoutAction.m
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BSignoutAction.h"

@implementation BSignoutAction

-(id) init
{
    self = [super initWithActionURLString:@"users/sign_out.json"];
    if( self )
    {
        self.isValid = YES;
    }
    return self;
}

@end
