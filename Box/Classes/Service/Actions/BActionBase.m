//
//  BActionBase.m
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "BActionBase.h"

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

@end

@implementation BActionGetBase

-(BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure{
    AFHTTPRequestOperationManager *manager = [[BHttpActionMgr shared] getHttpRequestMgr];
    if (!manager) {
        return NO;
    }
    [manager GET:self.url parameters:self.parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(self,responseObject,operation);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(self,error,operation);
    }];
    return YES;
}

@end
@implementation BActionPostBase


-(BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [[BHttpActionMgr shared] getHttpRequestMgr];
    
    if (!manager) {
        return NO;
    }
    [manager POST:self.url parameters:self.parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(self,responseObject,operation);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(self,error,operation);
    }];

    return YES;
}

@end

@implementation BActionDeleteBase

-(BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure{
    AFHTTPRequestOperationManager *manager = [[BHttpActionMgr shared] getHttpRequestMgr];
    
    if (!manager) {
        return NO;
    }
    
    [manager DELETE:self.url parameters:self.parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(self,responseObject,operation);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(self,error,operation);
    }];
    
    return YES;
}

@end


















