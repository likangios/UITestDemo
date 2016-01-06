//
//  CALayer+BLayerBorderColor.m
//  Box
//
//  Created by FengLing on 16/1/5.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "CALayer+BLayerBorderColor.h"

@implementation CALayer (BLayerBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)borderColorWithUIColor{
    self.borderColor = borderColorWithUIColor.CGColor;
}
@end
