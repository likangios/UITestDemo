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

- (void)setModel:(BUUIDinfoModel *)model{
    _model = model;
    if (_model) {
    _courseCardView.studentSchool.text = _model.organization_name;
    _courseCardView.studentName.text = _model.student_name;
        _courseCardView.studentClass.text = [NSString stringWithFormat:@"班级：%@",_model.class_name];
    }
}
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
-(CGFloat)getCellHeight{
    return 90;
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
