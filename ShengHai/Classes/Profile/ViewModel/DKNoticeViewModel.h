//
//  DKNoticeViewModel.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewModel.h"

#import "DKNotice.h"
#import "DKScheduleParam.h"
#import "DKMonthCalendar.h"
#import "DKOrderRemindCount.h"

@interface DKNoticeViewModel : DKViewModel

@property (nonatomic, strong, readonly) NSArray<DKNotice *> *notices;

/** 日程参数 */
@property (nonatomic, strong) DKScheduleParam *param;

/** 当前月 */
@property (nonatomic, strong) DKMonthCalendar *monthCalendar;
/** 下个月 */
@property (nonatomic, strong) DKMonthCalendar *nextMonthCalendar;
/** 订单提示数量 */
@property (nonatomic, strong) DKOrderRemindCount *orderRemindCount;

/** 获取通知中心 */
@property (nonatomic, strong, readonly) RACCommand *fetchNoticeListCommand;
/** 获取通知中心未读消息数 */
@property (nonatomic, strong, readonly) RACCommand *fetchNoticeUnreadCommand;

/** 获取日程时间数组 */
@property (nonatomic, strong, readonly) RACCommand *fetchMonthCalendarCommand;

/** 获取订单提醒数量 */
@property (nonatomic, strong, readonly) RACCommand *fetchOrderRemindCountCommand;

@end
