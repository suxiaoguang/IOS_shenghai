//
//  DKProfileService.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKProfileService : NSObject

/**
 退出登录
 
 @return RACSignal
 */
+ (RACSignal *)logout;

/**
 上班
 
 @return RACSignal
 */
+ (RACSignal *)startWork;

/**
 下班
 
 @return RACSignal
 */
+ (RACSignal *)outWork;


/**
 更新头像

 @param headimgurl 头像地址
 @return RACSignal
 */
+ (RACSignal *)updateHeadImage:(NSString *)headimgurl;

/**
 获取通讯录列表
 
 @return RACSignal
 */
+ (RACSignal *)fetchStaffList;


/**
 获取订单统计数量

 @return RACSignal
 */
+ (RACSignal *)fetchOrderNumber;

/**
 获取用户评分
 
 @return RACSignal
 */
+ (RACSignal *)fetchAccountScore;

/**
 获取用户评分列表
 
 @param page 页码
 @param num 每页数量
 @return RACSignal
 */
+ (RACSignal *)fetchAccountScoreListWithPage:(NSNumber *)page num:(NSInteger)num;

/**
 获取用户评分详情

 @param orderId  订单id
 @return RACSignal
 */
+ (RACSignal *)fetchStarInfoDetailWithOrderId:(NSString *)orderId;


/**
 填写意见反馈

 @param content 意见反馈内容
 @return RACSignal
 */
+ (RACSignal *)writeFeedbackWithContent:(NSString *)content;

/**
 获取消息通知列表
 
 @param page 页码
 @param num 每页数量
 @return RACSignal
 */
+ (RACSignal *)fetchNoticeListWithPage:(NSNumber *)page num:(NSInteger)num;

/**
 获取消息通知未读数

 @return RACSignal
 */
+ (RACSignal *)fetchNoticeUnread;

/**
 获取工程师日程

 @param year 年份
 @param month 月份
 @return RACSignal
 */
+ (RACSignal *)fetchMonthCalendarWithYear:(NSString *)year month:(NSString *)month;

/**
 获取日程列表

 @param year 年份
 @param month 月份
 @param day 日
 @return RACSignal
 */
+ (RACSignal *)fetchDayCalendarListWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

/**
 获取常见问题

 @return RACSignal
 */
+ (RACSignal *)fetchQuestions;


/**
 获取平台规则

 @return RACSignal
 */
+ (RACSignal *)fetchRules;

/**
 获取联系方式

 @return RACSignal
 */
+ (RACSignal *)fetchContactInformation;


/**
 获取订单提醒数量

 @return RACSignal
 */
+ (RACSignal *)fetchOrderRemindCount;


/**
 获取联系人地区

 @return RACSignal
 */
+ (RACSignal *)fetchContactAreaList;


/**
 获取小区域联系人

 @param mainArea 大区
 @param subArea 小区
 @return RACSignal
 */
+ (RACSignal *)fetchContactPeopleListWithMainArea:(NSString *)mainArea subArea:(NSString *)subArea;


/**
 搜索联系人

 @param keyword 搜索关键字
 @return RACSignal
 */
+ (RACSignal *)searchContactWithKeyWord:(NSString *)keyword;

@end
