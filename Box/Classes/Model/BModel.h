//
//  BModel.h
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "JSONModel.h"

@interface BModel : JSONModel

/**
 *  对象的唯一id
 */
@property (nonatomic,strong)    NSNumber    *guid;
/**
 *  创建时间
 */
@property(nonatomic,strong) NSString *created_at;
/**
 *  对象类型
 */
@property(nonatomic,strong) NSString *object_name;

/**
 *  归档
 *
 *  @param path 路径
 *
 *  @return 成功YES 失败NO
 */
- (BOOL)archiveRootObjectWithPath:(NSString *)path;
/**
 *  解档
 *
 *  @param path 路径
 *
 *  @return 成功YES 失败NO
 */
- (id)unarchiveObjectWithFileWithPath:(NSString *)path;
@end
