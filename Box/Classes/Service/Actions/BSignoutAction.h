//
//  BSignoutAction.h
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BActionBase.h"
/**
 登出请求
 */
@interface BSignoutAction : BActionPostBase
/**
 *  new 并且初始化对象
 *
 *  @return 返回对象，有效与否看 IsValid 属性
 */
-(id) init;
@end
