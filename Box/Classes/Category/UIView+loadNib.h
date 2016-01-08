//
//  UIView+loadNib.h
//  dyViews
//
//  Created by FengLing on 15/12/3.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (loadNib)

@property (nonatomic,strong) NSString *tagString;

+(id)loadSelfWithNibOwner:(id)owner;
- (UIView *)viewWithTagString:(NSString *)value;
@end
