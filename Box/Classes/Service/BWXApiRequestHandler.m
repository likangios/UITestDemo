//
//  BWXApiRequestHandler.m
//  Box
//
//  Created by FengLing on 16/1/6.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BWXApiRequestHandler.h"
#import "BWXApiManager.h"
@implementation BWXApiRequestHandler
+ (BOOL)sendAuthRequestScope:(NSString *)scope
                       State:(NSString *)state
                      OpenID:(NSString *)openID
            InViewController:(UIViewController *)viewController {
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = scope; // @"post_timeline,sns"
    req.state = state;
    req.openID = openID;
    
    return [WXApi sendAuthReq:req
               viewController:viewController
                     delegate:[BWXApiManager sharedManager]];
}
@end
