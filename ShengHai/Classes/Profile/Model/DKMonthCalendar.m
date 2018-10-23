//
//  DKMonthCalendar.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/10.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKMonthCalendar.h"

@implementation DKMonthCalendar

- (NSMutableArray *)timeArray
{
    if (!_timeArray) {
        _timeArray = [NSMutableArray array];
        @weakify(self);
        [self.day_list enumerateObjectsUsingBlock:^(NSString * _Nonnull day, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            [_timeArray addObject:[NSString dk_stringWithFormat:@"%@-%@-%@",self.year,self.month,day]];
        }];
    }
    return _timeArray;
}

@end
