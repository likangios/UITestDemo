//
//  BWeChatLoginAction.h
//  Box
//
//  Created by FengLing on 16/1/15.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BActionBase.h"

@interface BWeChatLoginAction : BActionPostBase
-(id)initWithCode:(NSString *)code sign:(NSString *)sign;
@end
