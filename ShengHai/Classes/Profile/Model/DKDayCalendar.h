//
//  DKDayCalendar.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/10.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKDayCalendar : NSObject

/** 订单id */
@property (nonatomic, copy) NSString *order_id;
/** 地址 */
@property (nonatomic, copy) NSString *contact_address;
/** 预约时间 */
@property (nonatomic, copy) NSString *appoint_time;
/** 订单创建时间 */
@property (nonatomic, copy) NSString *order_create_time;
/** 状态 */
@property (nonatomic, copy) NSString *status_text;

@end
