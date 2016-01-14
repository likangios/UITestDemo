//
//  BMessageResource.h
//  Box
//
//  Created by 哈哈哈 on 16/1/14.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BModel.h"

@protocol BMessageResource <NSObject>

@end

@interface BMessageResource : BModel

@property (nonatomic,strong) NSString *messageResource_id;
@property (nonatomic,strong) NSString *message_id;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *type;

@end
