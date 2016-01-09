//
//  BCourseCardCell.h
//  Box
//
//  Created by 哈哈哈 on 16/1/9.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCourseCardCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,copy) void (^DeleteCourseBlocks)(NSIndexPath *indexPath);
@end
