//
//  BDateTimeCell.m
//  Box
//
//  Created by 哈哈哈 on 16/1/10.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BDateTimeCell.h"

@interface BDateTimeCell ()

@property (nonatomic,strong) IBOutlet UILabel *dateLabel;

@end

@implementation BDateTimeCell

-(CGFloat)getCellHeight{
    return 32.5;
}
- (void)setHasUnReadMessage:(BOOL)hasUnReadMessage{
    if (hasUnReadMessage) {
        self.dateLabel.textColor = color_red;
    }else{
        self.dateLabel.textColor = B_color(153, 153, 153);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDateString:(NSString *)dateString{
    self.dateLabel.text= dateString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
