//
//  BActionBase.h
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BActionBase;

typedef void(^ActionSuccessBlock)(BActionBase *action,id responseObject,AFHTTPRequestOperation *operation);
typedef void(^ActionFailureBlock)(BActionBase *action,NSError *error,AFHTTPRequestOperation *operation);

@interface BActionBase : NSObject


@property (nonatomic,strong)NSMutableDictionary *parameters;

- (id)initWithActionURLString:(NSString *)str_url;
- (NSString *)get_action_url;

- (BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure;

@end

@interface BActionGetBase : BActionBase

@end

@interface BActionPostBase : BActionBase

@end

@interface BActionDeleteBase : BActionBase

@end
