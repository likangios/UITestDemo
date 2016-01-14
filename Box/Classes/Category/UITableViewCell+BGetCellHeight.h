//
//  UITableViewCell+BGetCellHeight.h
//  Box
//
//  Created by 哈哈哈 on 16/1/10.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (BGetCellHeight)
/**
 *  给cell 加的属性 设置cell的高度
 */
@property (nonatomic,strong) NSNumber *cellHeight;
/**
 *  获取cell的高度
 *
 *  @return 
 */
-(CGFloat)getCellHeight;
@end
