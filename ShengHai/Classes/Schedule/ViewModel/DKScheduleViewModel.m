//
//  DKScheduleViewModel.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/11.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKScheduleViewModel.h"
#import "DKProfileService.h"

@interface DKScheduleViewModel ()
@property (nonatomic, strong) RACCommand *fetchScheduleListCommand; // 获取日程列表
@property (nonatomic, strong) NSArray<DKDayCalendar *> *monthCalendars; // 日程订单
@end

@implementation DKScheduleViewModel
- (DKScheduleParam *)param
{
    if (!_param) {
        _param = [[DKScheduleParam alloc] init];
    }
    return _param;
}

- (NSArray<RACCommand *> *)commands
{
    return @[self.fetchScheduleListCommand
             ];
}

// 获取日程列表
- (RACCommand *)fetchScheduleListCommand
{
    if (!_fetchScheduleListCommand) {
        @weakify(self);
        _fetchScheduleListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[DKProfileService fetchDayCalendarListWithYear:self.param.year month:self.param.month day:self.param.day] map:^id(id value) {
                self.monthCalendars = value;
                return value;
            }];
        }];
    }
    return _fetchScheduleListCommand;
}

@end
