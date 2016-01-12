//
//  BBObjectList.m
//  Box
//
//  Created by FengLing on 16/1/12.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BObjectList.h"
#import "BModel.h"

@interface BObjectList ()

@property (nonatomic,retain)    NSMutableDictionary  *   impl;
@end

@implementation BObjectList

-(id) init
{
    self = [super init];
    if (self) {
        self.impl = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone{
    BObjectList *list = [[BObjectList alloc]init];
    list.impl = [self.impl copy];
    return list;
}
- (BModel *) Find:(id) guid
{
    BModel * ret = nil;
    
    if( self.impl != nil && guid )
    {
        ret = [self.impl objectForKey:guid];
    }
    
    return ret;
}

- (BOOL) Add:(BModel *)elm
{
    BOOL ret = NO;
    if( self.impl != nil && elm != nil && elm.guid  )
    {
        [ self.impl setObject:elm forKey:elm.guid ];
        ret = YES;
    }
    
    return ret;
}

- (void) Remove:(id) guid
{
    if(  guid )
    {
        [ self.impl removeObjectForKey: guid ];
    }
}

- (BModel *) GetIndexAt:(NSInteger) idx WithIsDESC:(BOOL) is_desc
{
    BModel * ret = nil;
    
    NSArray *sortedKeys = nil;
    if( is_desc )
    {
        sortedKeys = [self.impl keysSortedByValueUsingSelector:@selector(compareNumericallyDESC:)];
    }
    else
    {
        sortedKeys = [self.impl keysSortedByValueUsingSelector:@selector(compareNumericallyASC:)];
    }
    if( sortedKeys )
    {
        if( [sortedKeys count] >= idx + 1 )
        {
            NSNumber * key = [sortedKeys objectAtIndex:idx];
            ret = [self.impl objectForKey:key];
        }
    }
    
    return ret;
}


- (BModel *) GetMax
{
    NSUInteger count = [self.impl count];
    if( count > 0 )
    {
        return [self GetIndexAt:0 WithIsDESC:YES];
    }
    return nil;
}

- (BModel *) GetMin
{
    NSUInteger count = [self.impl count];
    if( count > 0 )
    {
        return [self GetIndexAt:0 WithIsDESC:NO];
    }
    return nil;
}

- (NSInteger)  GetIndexByObj:(BModel *) baseObj
{
    if( !baseObj )
        return -1;
    
    NSArray * allValues = [self.impl allValues];
    if( allValues )
    {
        NSInteger index = 0;
        NSEnumerator * itor = [allValues objectEnumerator];
        if( itor )
        {
            id value;
            while ( value = [itor nextObject] ) {
                BModel * elm = (BModel *)value;
                if( elm == baseObj )
                {
                    return index;
                }
                index += 1;
            }
        }
    }
    
    return -1;
}

- (void) ClearAll
{
    [self.impl removeAllObjects];
}

- (void) LimitSizeByGUID:(NSUInteger) limit_size
{
    if( [self.impl count] > limit_size )
    {
        NSUInteger remove_count = [self.impl count] - limit_size;
        NSArray *sortedKeys = [self.impl keysSortedByValueUsingSelector:@selector(compareNumericallyASC:)];
        
        for (NSUInteger n = 0; n < remove_count; n++) {
            [self.impl removeObjectForKey:[sortedKeys objectAtIndex:n]];
        }
    }
}

- (NSUInteger) GetCount
{
    NSUInteger count =  [self.impl count];
    return count;
}



- (void) appendFromBObjectList:(BObjectList *) otherList
{
    if( otherList && otherList.impl )
    {
        [self.impl addEntriesFromDictionary:otherList.impl];
    }
}





@end
