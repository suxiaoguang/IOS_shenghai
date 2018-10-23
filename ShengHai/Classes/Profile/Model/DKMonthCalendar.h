//
//  DKMonthCalendar.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/10.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKMonthCalendar : NSObject

/** 年份 */
@property (nonatomic, copy) NSString *year;
/** 月份 */
@property (nonatomic, copy) NSString *month;
/** 日(数组) */
@property (nonatomic, strong) NSArray *day_list;

/** 年月日(数组) */
@property (nonatomic, strong) NSMutableArray *timeArray;

@end
