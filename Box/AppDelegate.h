//
//  AppDelegate.h
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>
//lib
//#import <GeTuiSdk.h>



//@interface AppDelegate : UIResponder <UIApplicationDelegate,GeTuiSdkDelegate>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 *  是否登陆
 */
@property (assign, nonatomic) BOOL isLogin;

@property (assign, nonatomic) BOOL isWXLogin;

@property (strong, nonatomic) NSString *token;

-(void) OnSignInSuccessful:(NSString * )acc WithPassword:(NSString *) password;

-(void) OnSignoutSuccessful;

- (void)WeChatLoginCode:(NSString *)code sign:(NSString *)sign;

- (void)wxFastLogin:(NSString *)token;

- (void)testNotification;
@end

