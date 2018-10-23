//
//  DKNoticeViewModel.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKNoticeViewModel.h"

#import "DKProfileService.h"
#import "DKMonthCalendar.h"

@interface DKNoticeViewModel ()
@property (nonatomic, strong) NSArray<DKNotice *> *notices;
@property (nonatomic, strong) RACCommand *fetchNoticeListCommand;
@property (nonatomic, strong) RACCommand *fetchNoticeUnreadCommand;
@property (nonatomic, strong) RACCommand *fetchMonthCalendarCommand; // 获取日程时间数组
@property (nonatomic, strong) RACCommand *fetchOrderRemindCountCommand; // 获取订单提醒数量
@end

@implementation DKNoticeViewModel
- (DKScheduleParam *)param
{
    if (!_param) {
        _param = [[DKScheduleParam alloc] init];
    }
    return _param;
}

- (RACCommand *)loadDataCommand
{
    return self.fetchNoticeListCommand;
}

- (NSArray<RACCommand *> *)commands
{
    return @[self.fetchNoticeListCommand,
             self.fetchNoticeUnreadCommand,
             self.fetchMonthCalendarCommand,
			 self.fetchOrderRemindCountCommand
             ];
}

// 获取通知列表
- (RACCommand *)fetchNoticeListCommand
{
    if (!_fetchNoticeListCommand) {
        @weakify(self);
        _fetchNoticeListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[DKProfileService fetchNoticeListWithPage:input num:DKPageSize] map:^id(id value) {
                if ([input integerValue] > 1) {
                    if (![value count]) [self.noMoreSubject sendNext:nil];
                    value = [self.notices arrayByAddingObjectsFromArray:value];
                }
                return value;
            }];
        }];
    }
    return _fetchNoticeListCommand;
}

// 获取通知未读数
- (RACCommand *)fetchNoticeUnreadCommand
{
    if (!_fetchNoticeUnreadCommand) {
        _fetchNoticeUnreadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [DKProfileService fetchNoticeUnread];
        }];
    }
    return _fetchNoticeUnreadCommand;
}

// 获取日程时间数组
- (RACCommand *)fetchMonthCalendarCommand
{
    if (!_fetchMonthCalendarCommand) {
        @weakify(self);
        _fetchMonthCalendarCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[[DKProfileService fetchMonthCalendarWithYear:self.param.scheduleYear month:self.param.scheduleMonth] map:^id(DKMonthCalendar *monthCalendar) {
                self.monthCalendar = monthCalendar;
                return monthCalendar;
            }] then:^RACSignal *{
                NSString *year = [self.param.scheduleMonth isEqualToString:@"12"] ? [NSString dk_stringWithFormat:@"%ld",(long)(self.param.scheduleYear.integerValue + 1)] : self.param.scheduleYear;
                NSString *month = [self.param.scheduleMonth isEqualToString:@"12"] ? @"1" : [NSString dk_stringWithFormat:@"%ld",(long)(self.param.month.integerValue + 1)];
                return [[DKProfileService fetchMonthCalendarWithYear:year month:month] map:^id(id value) {
                    self.nextMonthCalendar = value;
                    [self.monthCalendar.timeArray arrayByAddingObjectsFromArray:self.nextMonthCalendar.timeArray];
                    return value;
                }];
            }];
        }];
    }
    return _fetchMonthCalendarCommand;
}

// 获取订单提醒数量
- (RACCommand *)fetchOrderRemindCountCommand
{
	if (!_fetchOrderRemindCountCommand) {
		@weakify(self);
		_fetchOrderRemindCountCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
			@strongify(self);
			return [[DKProfileService fetchOrderRemindCount] map:^id(id value) {
				self.orderRemindCount = value;
				return value;
			}];
		}];
	}
	return _fetchOrderRemindCountCommand;
}

- (void)setup
{
    [super setup];
    @weakify(self);
    [self.fetchNoticeListCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.notices = x;
    }];
}

@end
