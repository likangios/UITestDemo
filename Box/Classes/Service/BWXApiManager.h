//
//  BWXApiManager.h
//  Box
//
//  Created by FengLing on 16/1/6.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
@protocol BWXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

@end

@interface BWXApiManager : NSObject<WXApiDelegate>

@property (nonatomic, weak) id<BWXApiManagerDelegate> delegate;
/**
 *  微信APImanager 单利
 *
 *  @return 
 */
+ (instancetype)sharedManager;
/**
 *  是否安装微信
 *
 *  @return YES 安装  NO没安装
 */
+ (BOOL)isWXAppInstalled;
@end
