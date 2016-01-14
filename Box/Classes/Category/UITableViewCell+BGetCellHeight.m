//
//  UITableViewCell+BGetCellHeight.m
//  Box
//
//  Created by 哈哈哈 on 16/1/10.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "UITableViewCell+BGetCellHeight.h"
#import <objc/runtime.h>

@implementation UITableViewCell (BGetCellHeight)

static char strAddrKey = 'cellheight';

-(NSNumber *)cellHeight{
    return objc_getAssociatedObject(self, &strAddrKey);
}
- (void)setCellHeight:(NSNumber*)cellHeight{
objc_setAssociatedObject(self, &strAddrKey, cellHeight, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CGFloat)getCellHeight{
    return self.cellHeight.floatValue;
}
@end
