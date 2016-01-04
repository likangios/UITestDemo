//
//  BModel.m
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "BModel.h"
#import <objc/runtime.h>

@implementation BModel
/**
 *  属性可选
 *
 *  @param propertyName <#propertyName description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList([self class], &count);
        
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            
            // 设置到成员变量身上
            [self setValue:value forKey:key];
        }
        
        free(ivars);
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}
- (BOOL)archiveRootObjectWithPath:(NSString *)path{
    
    return   [NSKeyedArchiver archiveRootObject:self toFile:path];
    
}
- (id)unarchiveObjectWithFileWithPath:(NSString *)path{
    
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
@end
