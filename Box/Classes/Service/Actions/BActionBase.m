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
    }
    return self;
}
- (NSString *)get_action_url{
  return  self.url;
}

- (BOOL)DoActionWithSuccess:(ActionSuccessBlock)success Failure:(ActionFailureBlock)failure{
    
    return YES;
    
}


@end
