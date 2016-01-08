//
//  UIView+loadNib.m
//  dyViews
//
//  Created by FengLing on 15/12/3.
//  Copyright © 2015年 lk. All rights reserved.
//

#import "UIView+loadNib.h"
#import <objc/runtime.h>

#undef   KEY_TAGSTRING
#define KEY_TAGSTRING     "UIView.tagString"

@implementation UIView (loadNib)

+(id)loadSelfWithNibOwner:(id)owner{

    NSString *string =  NSStringFromClass([self class]);
    id  obj = [[[NSBundle mainBundle]loadNibNamed:string owner:owner options:nil]lastObject];
    return obj;
}
- (NSString *)tagString {
    NSObject *obj = objc_getAssociatedObject(self, KEY_TAGSTRING);
    if (obj && [obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    }
    
    return nil;
}
- (void)setTagString:(NSString *)value {
    objc_setAssociatedObject(self, KEY_TAGSTRING, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)viewWithTagString:(NSString *)value {
    if (nil == value) {
        return nil;
    }
    
    for (UIView *subview in self.subviews) {
        NSString *tag = subview.tagString;
        if ([tag isEqualToString:value])
        {
            return subview;
        }
    }
    
    return nil;
}

@end
