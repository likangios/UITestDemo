//
//  BHttpActionMgr.m
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "BHttpActionMgr.h"

@interface BHttpActionMgr ()

@property (nonatomic,strong)AFHTTPSessionManager *httpRequestMgr;

@end

static BHttpActionMgr *shareMgr = nil;


@implementation BHttpActionMgr

- (NSString *)getBaseUrlString{
    NSString *host = nil;
    
#if defined(BOX_DEVELOPMENT)
    host = @"http://192.168.1.1";
#elif defined(BOX_UAT)
    host = @"http://uat.box.app.xuexuecan.com";
#elif defined(BOX_PRODUCTION)
    host = @"";
#endif
    return host;
}

+(id)shared{
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        shareMgr = [[BHttpActionMgr alloc]init];
        
        NSURL *base_url = [NSURL URLWithString:[shareMgr getBaseUrlString]];
        AFHTTPSessionManager *manager =[[AFHTTPSessionManager alloc]initWithBaseURL:base_url];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        shareMgr.httpRequestMgr = manager;
        
    });
    return shareMgr;
}
- (AFHTTPSessionManager *)getHttpRequestMgr{
    shareMgr.httpRequestMgr.securityPolicy.allowInvalidCertificates = NO;
    return shareMgr.httpRequestMgr;
}

- (AFHTTPSessionManager *)getHttpsRequestMgr{
    shareMgr.httpRequestMgr.securityPolicy.allowInvalidCertificates = NO;
    return shareMgr.httpRequestMgr;
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
