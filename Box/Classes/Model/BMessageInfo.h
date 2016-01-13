//
//  BMessageInfo.h
//  Box
//
//  Created by 哈哈哈 on 16/1/13.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BModel.h"

@class BMessageResource;


@interface BMessageInfo : BModel

@property (nonatomic,strong) NSString *uuid;
@property (nonatomic,strong) NSString *message_id;

@property (nonatomic,strong) NSString *message_content;
@property (nonatomic,strong) NSString *message_createdAt;
@property (nonatomic,strong) NSArray<BMessageResource*> *message_resource;
@property (nonatomic,strong) NSString *messageTag_name;
@property (nonatomic,strong) NSString *messageUuid_id;
@property (nonatomic,strong) NSString *messageUuid_status;

@end

@interface BMessageResource : BModel
@property (nonatomic,strong) NSString *messageResource_id;
@property (nonatomic,strong) NSString *message_id;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *type;
@end
