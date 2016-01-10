//
//  BClassRoomPerformanceCell.m
//  Box
//
//  Created by 哈哈哈 on 16/1/10.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BClassRoomPerformanceCell.h"

@interface BClassRoomPerformanceCell ()

/**
 *  内容
 */
@property (nonatomic,strong) IBOutlet UIView *bgview;
/**
 *  内容
 */
@property (nonatomic,strong) IBOutlet UILabel *content;
/**
 *  是否读过
 */
@property (nonatomic,strong) IBOutlet UILabel *isRead;
/**
 *  课堂表现图片
 */
@property (nonatomic,strong) IBOutlet UIImageView *contentimg;

@end

@implementation BClassRoomPerformanceCell

- (void)awakeFromNib {
    // Initialization code
}
-(CGFloat)getCellHeight{
    return 162.0;
}
-(void)isReadedWith:(BOOL)rect{
    if (rect) {
        _bgview.layer.borderColor = color_red.CGColor;
        _isRead.textColor = color_red;
        _isRead.text = @"未读";
    }else{
        _bgview.layer.borderColor = color_gray.CGColor;
        _isRead.textColor = color_gray;
        _isRead.text = @"已读";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
