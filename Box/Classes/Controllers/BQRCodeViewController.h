//
//  BQRCodeViewController.h
//  Box
//
//  Created by FengLing on 16/1/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BBaseViewController.h"

@interface BQRCodeViewController : BBaseViewController

@property (nonatomic,copy) void (^QRCodeBlocks)(BOOL isSuccess,NSString *courseInfo);

@end
