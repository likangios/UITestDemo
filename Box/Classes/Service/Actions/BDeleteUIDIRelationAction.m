//
//  BDeleteUIDIRelationAction.m
//  Box
//
//  Created by FengLing on 16/1/12.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BDeleteUIDIRelationAction.h"

@implementation BDeleteUIDIRelationAction
-(instancetype)initWithUUID:(NSString *)uuid{
    self = [super initWithActionURLString:@"/api/v1/user/uuid/delUuidRelation.json"];
    if (self) {
        self.parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:uuid,@"uuid", nil];
    }
    self.isValid = YES;
    return self;
}
@end
