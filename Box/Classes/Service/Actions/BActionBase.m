//
//  BActionBase.m
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "BActionBase.h"
#import "AppDelegate.h"
@interface BActionBase ()

@property (nonatomic,strong) NSString *url;

@end


@implementation BActionBase


- (id)initWithActionURLString:(NSString *)str_url{
    self = [super init];
    if (self) {
        self.url = str_url;
        self.isValid = NO;
    }
    return self;
}
- (NSString *)get_action_url{
  return  self.url;
}

- (BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure{
    
    return NO;
    
}

- (BOOL)checkActionClassIsLogined{
    
    NSArray *classs = @[@"BActionLogin",@"BSignoutAction",@"BConfirmCodeAction.h",@"BSignupWithPhoneAction",@"BActionFindPWD"];
    for (NSString *classname in classs) {
        if ([self isKindOfClass:NSClassFromString(classname)]) {
            return NO;
            break;
        }
    }
    return YES;
    
}
- (void)loginout{
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdele OnSignoutSuccessful];
}

@end

@implementation BActionGetBase

-(BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure{
    AFHTTPSessionManager *manager = [[BHttpActionMgr shared] getHttpRequestMgr];
    if (!manager) {
        return NO;
    }
    [manager GET:self.url parameters:self.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
        success(self,responseObject,task);
        
        if (result.get_error_code == 10&&[self checkActionClassIsLogined]) {
        [self performSelector:@selector(loginout) withObject:nil afterDelay:2.0];
        }
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        failure(self,error,task);
    }];
    return YES;
}

@end
@implementation BActionPostBase


-(BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure
{
    AFHTTPSessionManager *manager = [[BHttpActionMgr shared] getHttpRequestMgr];
    
    if (!manager) {
        return NO;
    }
    [manager POST:self.url parameters:self.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BResponeResult *result = [BResponeResult createWithResponeObject:responseObject];
        success(self,responseObject,task);
        
        if (result.get_error_code == 10&&[self checkActionClassIsLogined]) {
        [self performSelector:@selector(loginout) withObject:nil afterDelay:2.0];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(self,error,task);
    }];

    return YES;
}
@end

@implementation BActionDeleteBase

-(BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure{
    AFHTTPSessionManager *manager = [[BHttpActionMgr shared] getHttpRequestMgr];
    
    if (!manager) {
        return NO;
    }
    [manager DELETE:self.url parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(self,responseObject,task);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(self,error,task);
        

    }];

    return YES;
}

@end


















