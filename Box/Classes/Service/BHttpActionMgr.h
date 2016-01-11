//
//  BHttpActionMgr.h
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHttpActionMgr : NSObject

/**
 *  单利
 *
 *  @return
 */
+(id)shared;
/**
 *  获取http操作管理器
 *
 *  @return
 */
- (AFHTTPSessionManager *)getHttpRequestMgr;
/**
 *  获取https操作管理器
 *
 *  @return
 */
- (AFHTTPSessionManager *)getHttpsRequestMgr;
/**
 *  清除缓存
 */
- (void)ClearCookies;
@end
