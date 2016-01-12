//
//  BGetUUIDRelationListAction.m
//  Box
//
//  Created by FengLing on 16/1/12.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BGetUUIDRelationListAction.h"

@implementation BGetUUIDRelationListAction
- (instancetype)init{
    self = [super initWithActionURLString:@"/api/v1/user/uuid/getUuidRelationList.json"];
    if (self) {
        
    }
    self.isValid = YES;
    return self;
}
@end
