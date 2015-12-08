//
//  BHttpActionMgr.m
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "BHttpActionMgr.h"

@interface BHttpActionMgr ()

@property (nonatomic,strong)AFHTTPRequestOperationManager *httpRequestMgr;

@end

static BHttpActionMgr *shareMgr = nil;


@implementation BHttpActionMgr

- (NSString *)getBaseUrlString{
    NSString *host = nil;
    
#if defined(BOX_DEVELOPMENT)
    host = @"";
#elif defined(BOX_UAT)
    host = @"";
#elif defined(BOX_PRODUCTION)
    host = @"";
#endif
    return host;
}

+(id)shared{
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        shareMgr = [[self class]init];
        
        NSURL *base_url = [NSURL URLWithString:[shareMgr getBaseUrlString]];
        AFHTTPRequestOperationManager *manager =[[AFHTTPRequestOperationManager alloc]initWithBaseURL:base_url];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        shareMgr.httpRequestMgr = manager;
        
    });
    return shareMgr;
}
-(void) ClearCookies
{
    NSURL * base_url = [NSURL URLWithString:[shareMgr getBaseUrlString]];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: base_url];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}
@end
