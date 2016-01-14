//
//  BObjectFactory.h
//  Box
//
//  Created by FengLing on 16/1/12.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMainCardModel.h"
#import "BHomeworkModel.h"
#import "BClassRoomPerformanceModel.h"
#import "BBeforeClassModel.h"
#import "BUserBaseModel.h"
#import "BUUIDinfoModel.h"
#import "BObjectList.h"
#import "BMessageInfo.h"

typedef id (^objectCreator)(NSDictionary * data);

/**
 *  对象工厂
 */
@interface BObjectFactory : NSObject

+ (id)shared;

-(id) createWithClassType:(NSString *) class_type JsonDirectory:(NSDictionary *) data;

@end
