//
//  BCourseCardCell.h
//  Box
//
//  Created by 哈哈哈 on 16/1/9.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BBaseCell.h"
@interface BCourseCardCell : BBaseCell

@property (nonatomic,strong) BUUIDinfoModel *model;
@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,copy) void (^DeleteCourseBlocks)(NSIndexPath *indexPath);
@end
