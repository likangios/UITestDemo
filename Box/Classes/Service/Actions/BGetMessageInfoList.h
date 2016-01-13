//
//  BGetMessageInfoList.h
//  Box
//
//  Created by 哈哈哈 on 16/1/13.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BActionBase.h"

@interface BGetMessageInfoList : BActionGetBase
-(id)initWithOffset:(NSNumber *)offset Limit:(NSNumber *)limit WithUUID:(NSString *)uuid;
@end
