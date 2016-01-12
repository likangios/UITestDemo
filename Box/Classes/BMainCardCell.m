//
//  BMainCardCell.m
//  Box
//
//  Created by 哈哈哈 on 16/1/8.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BMainCardCell.h"
#import "BMainCardView.h"

@interface BMainCardCell ()

@property (nonatomic,strong) BMainCardView *cardView;

@end

@implementation BMainCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initview];
    }
    return self;
}
-(CGFloat)getCellHeight{
    return 160.0;
}
- (void)initview{
    _cardView = [BMainCardView loadSelfWithNibOwner:self];
    [self.contentView addSubview:_cardView];
    [_cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}
-(void)setModel:(BUUIDinfoModel *)model{
    _model = model;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
