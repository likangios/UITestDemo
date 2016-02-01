//
//  AppDelegate.m
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import <UMengAnalytics-NO-IDFA/MobClick.h>
#import "UMessage.h"
#import "BWXApiManager.h"
#import "BCustomNaViewController.h"
#import "BWelcomViewController.h"
#import "BMainViewController.h"
#import "ViewController.h"
#import "BStoreService.h"
#import "BWeChatLoginAction.h"
#import "BWeChatFastLoginAction.h"
#import "BUpdateToken.h"


NSString *const NotificationCategoryIdent = @"ACTIONABLE";
NSString *const NotificationActionOneIdent = @"ACTION_ONE";
NSString *const NotificationActionTwoIdent = @"ACTION_TWO";

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initSDImageCache];
//    [self initGeTui:launchOptions];
    [self NotificationSettings:launchOptions];
    [self initWXLogin];
//    [self initUM];
    self.window = [[UIWindow alloc]initWithFrame:ScreenBounds];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    self.window = [[UIWindow alloc]initWithFrame:ScreenBounds];
    BCustomNaViewController *nav = [[BCustomNaViewController alloc]initWithRootViewController:[[BWelcomViewController alloc]initWithNibName:@"BWelcomViewController" bundle:nil]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}
#pragma mark UM 推送
- (void)NotificationSettings:(NSDictionary *)launchOptions{
    
    //推送
    [UMessage removeAllTags:^(id responseObject, NSInteger remain, NSError *error) {
#if defined(BOX_TEST)
        [UMessage addTag:@"dev_test" response:^(id responseObject, NSInteger remain, NSError *error) {
        }];
#elif defined(BOX_UAT)
        [UMessage addTag:@"dev_uat" response:^(id responseObject, NSInteger remain, NSError *error) {
        }];
#elif defined(BOX_PRODUCTION)
        [UMessage addTag:@"pro" response:^(id responseObject, NSInteger remain, NSError *error) {
        }];
        [MobClick startWithAppkey:UMAPK reportPolicy:BATCH channelId:nil];
#endif
    }];
    
    //程序在前台是否推送
    [UMessage setAutoAlert:NO];
    if(SYSTEM_VERSION_LESS_THAN(@"8.0")){
        [UMessage startWithAppkey:UMAPK launchOptions:launchOptions];
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
        [UMessage setLogEnabled:YES];
    }else{
        //    register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
    }
    
    //    如需关闭推送，请使用[UMessage unregisterForRemoteNotifications]
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return  [WXApi handleOpenURL:url delegate:[BWXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [WXApi handleOpenURL:url delegate:[BWXApiManager sharedManager]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - private
- (void)initSDImageCache{
    NSString *bundledPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"DownloadImages"];
    [[SDImageCache sharedImageCache] addReadOnlyCachePath:bundledPath];
    
#if defined(BOX_DEVELOPMENT)
    [[SDImageCache sharedImageCache] cleanDisk];
#else
    if( [[SDImageCache sharedImageCache] getDiskCount] > 100 )
    {
        [[SDImageCache sharedImageCache] clearDisk];
    }
#endif
}
//- (void)initGeTui:(NSDictionary *)launchOptions{
//    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
//    [self registerRemoteNotification];
//}
- (void)initWXLogin{
    
    [WXApi registerApp:WxAppID withDescription:@"Box Login"];
}
- (void)initUM{
    [MobClick startWithAppkey:UMtongji reportPolicy:BATCH channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}
#pragma mark  login

-(void) OnSignInSuccessful:(NSString * )acc WithPassword:(NSString *) password{
    DDLogError(@"登录成功");
    _isLogin = YES;
    [self updateDeviceToken];
    [[BStoreService sharedStoreService] saveAccount:acc Password:password];
    BCustomNaViewController *nav = [[BCustomNaViewController alloc]initWithRootViewController:[[BMainViewController alloc]initWithNibName:@"BMainViewController" bundle:nil]];
    self.window.rootViewController = nav;
//    统计账号来源 本身
    [MobClick profileSignInWithPUID:acc];
    //微信登陆
//   [MobClick profileSignInWithPUID:acc provider:@"WX"];
}
-(void) OnSignoutSuccessful{
    DDLogError(@"登出");
    _isLogin = NO;
    _isWXLogin = NO;
    [[BStoreService sharedStoreService] removePassword];
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    [defau removeObjectForKey:WXFASTLOGINTOKEN];
    [defau synchronize];
    
    BCustomNaViewController *nav = [[BCustomNaViewController alloc]initWithRootViewController:[[BWelcomViewController alloc]initWithNibName:@"BWelcomViewController" bundle:nil]];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
}
#pragma mark 微信自动登录

- (void)wxFastLogin:(NSString *)token{
    
    NSString *sign =[BUntil MD5:[NSString stringWithFormat:@"%@-%@",token,CustomMD5Key]];
    BWeChatFastLoginAction *action = [[BWeChatFastLoginAction alloc]initWithToken:token sign:sign];
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
        if ([result get_error_code]== kServerErrorCode_OK) {
            DDLogDebug(@"自动登录成功");
            //更新wxtoken
            NSDictionary *dic = [result get_first_object];
            [self WxFastLoginSuccessfulNowToken:dic[@"wechat_token"]];
        }else{
            [BUntil showErrorHUDViewAtView:self.window WithTitle:[result get_messge]];
            [self OnSignoutSuccessful];
            
        }
    } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
        [BUntil showErrorHUDViewAtView:self.window WithTitle:@"网络出错"];
            [self OnSignoutSuccessful];
    }];

    
}
#pragma mark 微信授权完成--服务器返回用户信息 登陆成功

- (void)WeChatLoginCode:(NSString *)code sign:(NSString *)sign{
    
    BWeChatLoginAction *action = [[BWeChatLoginAction alloc]initWithCode:code sign:sign];
    
    [BUntil showHUDAddedTo:self.window.rootViewController.view];
    
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        BResponeResult *respon = [BResponeResult createWithResponeObject:responseObject];
        [BUntil hideAllHUDsForView:self.window.rootViewController.view];
        if (respon.get_error_code == kServerErrorCode_OK) {
            
            NSDictionary *dic = [respon get_first_object];
            
            [self WxFastLoginSuccessfulNowToken:dic[@"we_chat_fast_login_token"]];
            
        }else{
            [BUntil showErrorHUDViewAtView:self.window.rootViewController.view WithTitle:respon.get_messge];
        }

        
    } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
        [BUntil hideAllHUDsForView:self.window.rootViewController.view];
    }];

}
#pragma mark 微信登录成功
- (void)WxFastLoginSuccessfulNowToken:(NSString *)nowToken{
    _isWXLogin = YES;
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    [defau setValue:nowToken forKey:WXFASTLOGINTOKEN];
    [defau synchronize];
    
    [self signInSuccessConfig:nowToken];
}
#pragma mark 登录成功配置
- (void)signInSuccessConfig:(NSString *)token{
    _isLogin = YES;
    [self updateDeviceToken];
    BCustomNaViewController *nav = [[BCustomNaViewController alloc]initWithRootViewController:[[BMainViewController alloc]initWithNibName:@"BMainViewController" bundle:nil]];
    self.window.rootViewController = nav;
//微信登陆
    [MobClick profileSignInWithPUID:token provider:@"wx_login"];
}
- (void)updateDeviceToken{
    
    if (_token.length&&_isLogin){
    BUpdateToken *action = [[BUpdateToken alloc]initWithToken:_token];
    [action DoActionWithSuccess:^(BActionBase *action, id responseObject, NSURLSessionDataTask *operation) {
        BResponeResult *result= [BResponeResult createWithResponeObject:responseObject];
        if (result.get_error_code == kServerErrorCode_OK) {
            DDLogDebug(@"发送token成功");
        }else{
            DDLogDebug(@"发送token失败");
        }
    } Failure:^(BActionBase *action, NSError *error, NSURLSessionDataTask *operation) {
            DDLogDebug(@"发送token失败");
    }];
    }
}
#pragma mark - 用户通知(推送) _自定义方法

/** 注册远程通知 */
/*
- (void)registerRemoteNotification {
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //IOS8 新的通知机制category注册
        UIMutableUserNotificationAction *action1;
        action1 = [[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeBackground];
        [action1 setTitle:@"取消"];
        [action1 setIdentifier:NotificationActionOneIdent];
        [action1 setDestructive:NO];
        [action1 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationAction *action2;
        action2 = [[UIMutableUserNotificationAction alloc] init];
        [action2 setActivationMode:UIUserNotificationActivationModeBackground];
        [action2 setTitle:@"回复"];
        [action2 setIdentifier:NotificationActionTwoIdent];
        [action2 setDestructive:NO];
        [action2 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationCategory *actionCategory;
        actionCategory = [[UIMutableUserNotificationCategory alloc] init];
        [actionCategory setIdentifier:NotificationCategoryIdent];
        [actionCategory setActions:@[ action1, action2 ]
                        forContext:UIUserNotificationActionContextDefault];
        
        NSSet *categories = [NSSet setWithObject:actionCategory];
        UIUserNotificationType types = (UIUserNotificationTypeAlert |
                                        UIUserNotificationTypeSound |
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                   UIRemoteNotificationTypeSound |
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}
*/
#pragma mark - background fetch  唤醒
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //[5] Background Fetch 恢复SDK 运行
//    [GeTuiSdk resume];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - 远程通知(推送)回调

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    _token = token;
    
    [self updateDeviceToken];
    
    NSLog(@"deviceToken:%@", token);
    
    [UMessage registerDeviceToken:deviceToken];

    // [3]:向个推服务器注册deviceToken
//    [GeTuiSdk registerDeviceToken:token];
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    // [3-EXT]:如果APNS注册失败，通知个推服务器
//    [GeTuiSdk registerDeviceToken:@""];
    
//    [_viewController logMsg:[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]]];
}
#pragma mark - APP运行中接收到通知(推送)处理

/** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台) */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // [4-EXT]:处理APN
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], userInfo];
    [UMessage didReceiveRemoteNotification:userInfo];
    
//    [_viewController logMsg:record];
}

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // [4-EXT]:处理APN
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], userInfo];
//    [_viewController logMsg:record];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark -- GeTuiDelegate --
/** SDK启动成功返回cid */
//- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
//    // [4-EXT-1]: 个推SDK已注册，返回clientId
//    DDLogDebug(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
//}
//
///** SDK遇到错误回调 */
//- (void)GeTuiSdkDidOccurError:(NSError *)error {
//    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
//    DDLogDebug(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
//}
/** SDK收到透传消息回调 */
//- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId {
//    
//    // [4]: 收到个推消息
//    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId];
//    NSString *payloadMsg = nil;
//    if (payload) {
//        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
//    }
//    
//    NSString *msg = [NSString stringWithFormat:@" payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@",payloadId,taskId,aMsgId,payloadMsg,offLine ? @"<离线消息>" : @""];
//    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
//    
//    /**
//     *汇报个推自定义事件
//     *actionId：用户自定义的actionid，int类型，取值90001-90999。
//     *taskId：下发任务的任务ID。
//     *msgId： 下发任务的消息ID。
//     *返回值：BOOL，YES表示该命令已经提交，NO表示该命令未提交成功。注：该结果不代表服务器收到该条命令
//     **/
//    [GeTuiSdk sendFeedbackMessage:90001 taskId:taskId msgId:aMsgId];
//}


@end
