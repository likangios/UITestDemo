//
//  BMainCardView.m
//  Box
//
//  Created by FengLing on 16/1/8.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BMainCardView.h"

@interface BMainCardView ()

@property (nonatomic,strong) IBOutlet UIView *contentView;
/**
 *  名字
 */
@property (nonatomic,strong) IBOutlet UILabel *student_name;
@property (nonatomic,strong) IBOutlet UILabel *student_age;
@property (nonatomic,strong) IBOutlet UILabel *organization_name;
@property (nonatomic,strong) IBOutlet UILabel *class_name;
@property (nonatomic,strong) IBOutlet UILabel *admission_time;
@property (nonatomic,strong) IBOutlet UILabel *unRead_number;

@end
@implementation BMainCardView

- (void)setModel:(BUUIDinfoModel *)model{
    _model = model;
    if (_model) {
        _student_name.text = _model.student_name;
        _student_age.text = [NSString stringWithFormat:@"年龄：%d岁",_model.student_age.intValue];
        _organization_name.text = _model.organization_name;
        _class_name.text = [NSString stringWithFormat:@"班级：%@",_model.class_name];
        _admission_time.text = [NSString stringWithFormat:@"入学时间：%@",_model.admission_time];
        _unRead_number.text = [NSString stringWithFormat:@"%d",_model.message_unreadCount.intValue];
        [self isReadedWith:_model.message_unreadCount.intValue];
    }
}
-(void)isReadedWith:(BOOL)rect{
    if (rect) {
        _contentView.layer.borderColor = color_red.CGColor;
        _unRead_number.hidden = NO;
    }else{
        _contentView.layer.borderColor = color_gray.CGColor;
        _unRead_number.hidden = YES;
    }
}
@end
