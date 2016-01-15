//
//  BWeChatFastLoginAction.h
//  Box
//
//  Created by FengLing on 16/1/15.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BActionBase.h"

@interface BWeChatFastLoginAction : BActionPostBase
-(id)initWithToken:(NSString *)token sign:(NSString *)sign;
@end
