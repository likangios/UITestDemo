//
//  BUntil.h
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  等于某个版本号
 *
 *
 *  @return 等于 YES  否则 NO
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
/**
 *  大于某个版本号
 *
 *
 *  @return 大于 YES 否则 NO
 */
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
/**
 *  大于或等于版本号
 *
 *
 *  @return 大于或等于 YES 否则 NO
 */
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
/**
 *  小于某个版本号
 *
 *
 *  @return 小于 YES 否则 NO
 */
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
/**
 *  小于等于V
 *
 *
 *  @return 小于或等于 YES 否则 NO
 */
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#ifndef IS_PHONE
#define IS_PHONE (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
#endif

@interface BUntil : NSObject

@end
