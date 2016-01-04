//
//  UIViewController+Tracking.m
//  xuexuecan
//
//  Created by 李康 on 15/8/17.
//  Copyright (c) 2015年 ICan. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)
+(void)load{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        SEL originalSelector = @selector(viewWillAppear:);
        
        SEL swizzledSelector = @selector(xxc_viewWillAppear:);
    
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        
    
        BOOL  didAddMethod = class_addMethod([self class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod([self class], swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
    
}
- (void)xxc_viewWillAppear:(BOOL)animated{
    [self xxc_viewWillAppear:animated];
    NSLog(@"Tracking_viewWillAppear:%@",self.class);
}
@end
