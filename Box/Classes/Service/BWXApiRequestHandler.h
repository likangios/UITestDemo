//
//  BWXApiRequestHandler.h
//  Box
//
//  Created by FengLing on 16/1/6.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h" 
@interface BWXApiRequestHandler : NSObject
+ (BOOL)sendAuthRequestScope:(NSString *)scope
                       State:(NSString *)state
                      OpenID:(NSString *)openID
            InViewController:(UIViewController *)viewController;
@end
