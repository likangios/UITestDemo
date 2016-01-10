//
//  BMainCardModel.h
//  Box
//
//  Created by 哈哈哈 on 16/1/10.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BModel.h"

/**
 *  主页model
 */
@interface BMainCardModel : BModel

/**
 *  年龄
 */
@property (nonatomic,strong) NSNumber *BMainCardModelAge;
/**
 *  名字
 */
@property (nonatomic,copy) NSString *BMainCardModelName;
/**
 *  学校
 */
@property (nonatomic,copy) NSString *BMainCardModelScholls;
/**
 *  班级
 */
@property (nonatomic,copy) NSString *BMainCardModelClass;
/**
 *  入学时间
 */
@property (nonatomic,copy) NSString *BMainCardModelTime;
/**
 *  未读消息数
 */
@property (nonatomic,strong) NSNumber *BMainCardModelUnReads;
/**
 *  是否读过
 */
@property (nonatomic,assign) BOOL BMainCardModelisRead;
@end
