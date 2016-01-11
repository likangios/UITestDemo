//
//  BConfirmCodeAction.m
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BConfirmCodeAction.h"

@implementation BConfirmCodeAction
-(id) initWithPhoneNumber:(NSString *) phone_number andTemplate_id:(NSString *)template_id{
    self=[super initWithActionURLString:@"/api/v1/sms/requestCode.json"];
    if (self) {
        self.parameters  = [[NSMutableDictionary alloc]initWithObjectsAndKeys:phone_number,@"phone_num",template_id,@"template_id", nil];
        self.isValid = YES;
    }
    
    return self;
}
@end
