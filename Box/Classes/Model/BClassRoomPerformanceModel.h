//
//  BClassRoomPerformanceModel.h
//  Box
//
//  Created by 哈哈哈 on 16/1/10.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BModel.h"
/**
 *  课堂表现Model
 */
@interface BClassRoomPerformanceModel : BModel

/**
 *  内容
 */
@property (nonatomic,copy) NSString *BClassRoomPerformanceModelcontent;
/**
 *  图片
 */
@property (nonatomic,copy) NSString *BClassRoomPerformanceModelimage;
/**
 *  是否已读
 */
@property (nonatomic,assign) BOOL BClassRoomPerformanceModelisRead;


@end
