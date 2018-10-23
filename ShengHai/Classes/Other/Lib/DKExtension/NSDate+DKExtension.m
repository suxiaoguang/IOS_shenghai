//
//  NSDate+DKExtension.m
//  DKExtension
//
//  Created by 庄槟豪 on 16/7/5.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "NSDate+DKExtension.h"

@implementation NSDate (DKExtension)

+ (NSString *)dk_currentDateStrWithFormat:(NSString *)format
{
    NSString *date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    date = [fmt stringFromDate:[NSDate date]];
    NSString *str = [NSString stringWithFormat:@"%@",date];
    return str;
}

- (NSString *)dk_dateStrWithFormat:(NSString *)format
{
    NSString *date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    date = [fmt stringFromDate:self];
    NSString *str = [NSString stringWithFormat:@"%@",date];
    return str;
}

+ (NSString *)dk_dateStrWithTimeStamp:(NSString *)timeStamp format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]]];
    
    return dateStr;
}

- (NSDate *)dk_dateAfterDays:(NSInteger)days
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *date = [cal dateByAddingUnit:NSCalendarUnitDay value:days toDate:self options:NSCalendarWrapComponents];
    return date;
}

@end
