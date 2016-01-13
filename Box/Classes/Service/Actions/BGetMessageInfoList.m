//
//  BGetMessageInfoList.m
//  Box
//
//  Created by 哈哈哈 on 16/1/13.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BGetMessageInfoList.h"

@implementation BGetMessageInfoList
-(id)initWithOffset:(NSNumber *)offset Limit:(NSNumber *)limit WithUUID:(NSString *)uuid{
    self = [super initWithActionURLString:@"/api/v1/message/getMessageInfoList.json"];
    if (self) {
        self.parameters = [NSMutableDictionary dictionary];
        if (offset) {
            [self.parameters setObject:offset forKeyedSubscript:@"offset"];
        }
        if (limit) {
            [self.parameters setObject:limit forKeyedSubscript:@"limit"];
        }
        if (uuid) {
            [self.parameters setObject:uuid forKeyedSubscript:@"uuid"];
        }
        self.isValid = YES;
        
    }
    return self;
}
@end
