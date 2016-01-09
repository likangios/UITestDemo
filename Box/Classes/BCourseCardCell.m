//
//  BCourseCardCell.m
//  Box
//
//  Created by 哈哈哈 on 16/1/9.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BCourseCardCell.h"
#import "BCourseCardView.h"

@interface BCourseCardCell ()

@property (nonatomic,strong) BCourseCardView *courseCardView;

@end

@implementation BCourseCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _courseCardView = [BCourseCardView loadSelfWithNibOwner:self];
    [_courseCardView.studentDelete addTarget:self action:@selector(deleteCourse) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_courseCardView];
    [_courseCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7.5);
        make.bottom.mas_equalTo(-7.5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    // Initialization code
}
- (void)deleteCourse{
    if (_DeleteCourseBlocks) {
        _DeleteCourseBlocks(_indexPath);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
