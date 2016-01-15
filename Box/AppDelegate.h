//
//  AppDelegate.h
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>
//lib
#import <GeTuiSdk.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate,GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void) OnSignInSuccessful:(NSString * )acc WithPassword:(NSString *) password;

-(void) OnSignoutSuccessful;

- (void)WeChatLoginCode:(NSString *)code sign:(NSString *)sign;

- (void)wxFastLogin:(NSString *)token;

@end

