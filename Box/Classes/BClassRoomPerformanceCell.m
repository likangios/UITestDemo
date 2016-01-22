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
-(void)setInfoModel:(BMessageInfo *)infoModel{
    _infoModel = infoModel;
    self.content.text = _infoModel.message_content;
    [self isReadedWith:[_infoModel.messageUuid_status isEqualToString:@"unread"]];
    if (_infoModel.message_resource.count) {
        self.cellHeight = @162;
        BMessageResource *resoure = _infoModel.message_resource[0];
        [self.contentimg sd_setImageWithURL:[NSURL URLWithString:resoure.url]];
        self.contentimg.hidden = NO;
    }else{
        self.contentimg.hidden = YES;
        self.cellHeight = @80;
    }
}
-(CGFloat)getCellHeight{
    return self.cellHeight.floatValue;
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
