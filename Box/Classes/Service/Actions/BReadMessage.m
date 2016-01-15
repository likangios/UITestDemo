//
//  BReadMessage.m
//  Box
//
//  Created by FengLing on 16/1/15.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BReadMessage.h"

@implementation BReadMessage
- (instancetype)initWithMessage_ID:(NSString *)message_id{
    self = [super initWithActionURLString:@"/api/v1/message/readMessage.json"];
    if (self) {
        self.parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:message_id,@"messageUuid_id", nil];
    }
    self.isValid = YES;
    return self;
}
@end
