//
//  NSDate+DKExtension.h
//  DKExtension
//
//  Created by 庄槟豪 on 16/7/5.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DKExtension)

/**
 根据所给的格式生成一个NSString类型的当前日期

 @param format 日期格式
 @return 当前日期（NSString）
 */
+ (NSString *)dk_currentDateStrWithFormat:(NSString *)format;

/**
 *  日期转字符串
 */
- (NSString *)dk_dateStrWithFormat:(NSString *)format;

/**
 *  把时间戳转成自定义格式的日期字符串
 */
+ (NSString *)dk_dateStrWithTimeStamp:(NSString *)timeStamp format:(NSString *)format;

/**
 某天后的日期

 @param days 天数
 @return NSDate
 */
- (NSDate *)dk_dateAfterDays:(NSInteger)days;

@end
