//
//  BUUIDinfoModel.h
//  Box
//
//  Created by FengLing on 16/1/12.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BModel.h"

@interface BUUIDinfoModel : BModel
@property(nonatomic,strong) NSString *uuid;
@property(nonatomic,strong) NSString *student_id;
@property(nonatomic,strong) NSString *student_name;
@property(nonatomic,strong) NSNumber *student_age;
@property(nonatomic,strong) NSString *organization_id;
@property(nonatomic,strong) NSString *organization_name;
@property(nonatomic,strong) NSString *class_id;
@property(nonatomic,strong) NSString *class_name;
@property(nonatomic,strong) NSString *admission_time;
@end
