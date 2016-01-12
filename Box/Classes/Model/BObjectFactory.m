//
//  BObjectFactory.m
//  Box
//
//  Created by FengLing on 16/1/12.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BObjectFactory.h"



static BObjectFactory *g_factory = nil;

@interface BObjectFactory()

@property (nonatomic,retain) NSMutableDictionary * impl_dict;

-(void) Initialization;
@end

@implementation BObjectFactory

-(id) createWithClassType:(NSString *) class_type JsonDirectory:(NSDictionary *) data
{
    // do to
    // 实现
    objectCreator creator = [self.impl_dict objectForKey:class_type];
    
    if( creator )
    {
        id ret = creator( data );
        return ret;
    }else{
        [self registerObject:class_type WithCreator:^id(NSDictionary *data) {
            return [[NSClassFromString(class_type) alloc]initWithDictionary:data error:nil];
        }];
        return [[NSClassFromString(class_type) alloc]initWithDictionary:data error:nil];
    }
    
    return nil;
}

-(void) Initialization
{
    [self registerObject:@"BMainCardModel" WithCreator:^id(NSDictionary *data) {
        return [[BMainCardModel alloc] initWithDictionary:data error:nil];
    }];
    [self registerObject:@"BHomeworkModel" WithCreator:^id(NSDictionary *data) {
        return [[BHomeworkModel alloc] initWithDictionary:data error:nil];
    }];
    [self registerObject:@"BClassRoomPerformanceModel" WithCreator:^id(NSDictionary *data) {
        return [[BClassRoomPerformanceModel alloc] initWithDictionary:data error:nil];
    }];
    [self registerObject:@"BBeforeClassModel" WithCreator:^id(NSDictionary *data) {
        return [[BBeforeClassModel alloc] initWithDictionary:data error:nil];
    }];
    [self registerObject:@"BUserBaseModel" WithCreator:^id(NSDictionary *data) {
        return [[BUserBaseModel alloc] initWithDictionary:data error:nil];
    }];
    
}

/**
 *  获得单件实例
 *
 *  @return 返回单件对象
 */
+ (id)shared
{
    if (!g_factory) {
        @synchronized(self) {
            if (!g_factory) {
                g_factory = [[self alloc] init];
                [g_factory Initialization];
            }
        }
    }
    return g_factory;
}



-(id) init
{
    self = [super init];
    if( self )
    {
        self.impl_dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL) registerObject:(NSString *) class_type WithCreator:(objectCreator) creator
{
    if( class_type && creator )
    {
        [self.impl_dict setObject:creator forKey:class_type];
        return YES;
    }
    
    assert(0);
    return NO;
}


@end
