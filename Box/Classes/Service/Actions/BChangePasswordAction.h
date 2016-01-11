//
//  BChangePasswordAction.h
//  Box
//
//  Created by 哈哈哈 on 16/1/11.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BActionBase.h"

@interface BChangePasswordAction : BActionPostBase
- (id)initWithOldPwd:(NSString *)oldPWD AndNewPwd:(NSString *)newpwd;
@end
