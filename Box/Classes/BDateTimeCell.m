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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
