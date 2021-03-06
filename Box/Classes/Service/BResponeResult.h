//
//  BResponeResult.h
//  Box
//
//  Created by FengLing on 15/12/8.
//  Copyright © 2015年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kServerErrorCode_OK,
    kServerErrorCode_NO_MODIFY=304,
    kServerErrorCode_EXISTED=107,
    kServerErrorCode_NotEXISTED = 105,
} kServerErrorCode;

@interface BResponeResult : NSObject
{
    NSDictionary *  _json;
}

@property (nonatomic, retain,readonly) NSDictionary * json_data;

/**
 *  使用服务器返回的json数据创建一个 TResponeResult 对象
 *
 *  @param responeObject 服务器返回的数据
 *
 *  @return 成功返回 TResponeResult 对象，失败返回nil
 */
+ (id) createWithResponeObject:(id) responeObject;

/**
 *  使用json数据创建一个 TResponeResult 对象
 *
 *  @param json json数据
 *
 *  @return 成功返回 TResponeResult 对象，失败返回nil
 */
- (id) initWithJsonRespone:(NSDictionary *) json;

/**
 *  getter
 *
 */
- (kServerErrorCode)  get_error_code;
- (NSString *)  get_messge;
- (id) get_data;


/**
 * 返回 array 格式的数据
 *
 *  @return 如果服务器返回的数据是 array 格式，则返回 NSArray 对象。否则返回nil
 */
- (NSArray *) try_get_data_with_array;

/**
 *  返回 NSDictonary 格式的数据
 *
 *  @return 如果服务器返回的数据是 NSDictionary 格式，则返回 NSDictonary 对象，否则返回nil
 */
- (NSDictionary *) try_get_data_with_dict;

/**
 *  获得第一个对象数据
 *
 *  @return 如果第一个数据是NSDictionary （包括在array中的第一个) , 则返回 NSDictionary 对象，否则返回nil
 */
- (NSDictionary *) get_first_object;

/**
 *  讲服务器返回的数据格式化成string
 *
 *  @return 返回格式化后的stringe shig
 */
- (NSString *) description;

@end
