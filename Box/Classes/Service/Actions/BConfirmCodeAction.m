//
//  BConfirmCodeAction.m
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BConfirmCodeAction.h"

@implementation BConfirmCodeAction
-(id) initWithPhoneNumber:(NSString *) phone_number{
    self=[super initWithActionURLString:@""];
    if (self) {
        self.parameters  = [[NSMutableDictionary alloc]initWithObjectsAndKeys:phone_number,@"phone_number", nil];
    }
    return self;
}
@end
