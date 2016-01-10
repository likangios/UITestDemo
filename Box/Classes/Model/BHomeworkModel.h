//
//  BHomeworkModel.h
//  Box
//
//  Created by 哈哈哈 on 16/1/10.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BModel.h"

/**
 *  课后作业Model
 */
@interface BHomeworkModel : BModel


@property (nonatomic,copy) NSString *BHomeworkModelcontent;

@property (nonatomic,strong) NSNumber *BHomeworkModelunReads;

@property (nonatomic,assign) BOOL BHomeworkModelisRead;

@end
