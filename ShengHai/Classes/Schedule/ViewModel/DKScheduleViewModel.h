//
//  DKScheduleViewModel.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/11.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewModel.h"
#import "DKScheduleParam.h"
#import "DKDayCalendar.h"
@interface DKScheduleViewModel : DKViewModel
/** 日程参数 */
@property (nonatomic, strong) DKScheduleParam *param;
/** 日程订单 */
@property (nonatomic, strong, readonly) NSArray<DKDayCalendar *> *monthCalendars;
/** 获取日程列表 */
@property (nonatomic, strong, readonly) RACCommand *fetchScheduleListCommand;
@end
