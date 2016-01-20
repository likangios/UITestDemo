//
//  BDateTimeCell.h
//  Box
//
//  Created by 哈哈哈 on 16/1/10.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BBaseCell.h"

/**
 *  日期
 */
@interface BDateTimeCell : BBaseCell

@property (nonatomic,strong) NSString *dateString;
@property (nonatomic,assign) BOOL hasUnReadMessage;
@end
