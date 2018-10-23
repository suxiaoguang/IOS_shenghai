//
//  DKOrderService.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKOrderService : NSObject

/**
 获取订单管理列表
 
 @param status 状态 0-4
 @param page 页码
 @param num 每页数量
 @return RACSignal
 */
+ (RACSignal *)fetchOrderListWithStatus:(NSInteger)status page:(NSNumber *)page num:(NSInteger)num;


/**
 获取订单详情

 @param orderId 订单Id
 @return RACSignal
 */
+ (RACSignal *)fetchOrderDetailWithOrderId:(NSString *)orderId;


/**
 立即处理订单

 @param orderId 订单Id
 @return RACSignal
 */
+ (RACSignal *)dealOrderWithOrderId:(NSString *)orderId;

/**
 预约订单
 
 @param orderId 订单Id
 @return RACSignal
 */
+ (RACSignal *)appointOrderWithOrderId:(NSString *)orderId appointTime:(NSString *)appointTime;

/**
 暂停订单

 @param orderId 订单Id
 @param reason 原因
 @return RACSignal
 */
+ (RACSignal *)pauseOrderWithOrderId:(NSString *)orderId reason:(NSString *)reason;

/**
 取消暂停订单
 
 @param orderId 订单Id
 @return RACSignal
 */
+ (RACSignal *)cancelPauseOrderWithOrderId:(NSString *)orderId;

/**
 取消订单
 
 @param orderId 订单Id
 @param reason 取消原因
 @param isCanResume 该订单否是能重新发起（传0，1）
 @return RACSignal
 */
+ (RACSignal *)cancelOrderWithOrderId:(NSString *)orderId reason:(NSString *)reason isCanResume:(NSString *)isCanResume;

/**
 完成订单

 @param orderId 订单ID
 @param weakId 知识库二级id
 @param questType 问题类型（知识库3级的text）
 @param fixPlan 解决方案（知识库3级的solution_plan，可编辑）
 @param solutionType 解决方式（传0，1，2）
 @param solutionResult 解决情况（传0，1，2）
 @return RACSignal
 */
+ (RACSignal *)completeOrderWithOrderId:(NSString *)orderId
                                 weakId:(NSString *)weakId
                              questType:(NSString *)questType
                                fixPlan:(NSString *)fixPlan
                           solutionType:(NSString *)solutionType
                         solutionRestlt:(NSString *)solutionResult
						   user_company:(NSString *)user_company;

/**
 转派订单
 
 @param orderId 订单Id
 @param staffId 工程师Id
 @return RACSignal
 */
+ (RACSignal *)turnOrderWithOrderId:(NSString *)orderId staffId:(NSString *)staffId;


/**
 获取订单知识库

 @return RACSignal
 */
+ (RACSignal *)fetchOrderWikiList;


/**
 获取转诊同事列表

 @return RACSignal
 */
+ (RACSignal *)fetchStaffList;


/**
 获取工程师上班状态

 @return RACSignal
 */
+ (RACSignal *)fetchWorkStates;

/**
 分享知识库

 @param class_two_id 知识库二级id
 @param wiki_text 方案名称
 @param fix_plan 方案内容
 @return RACSignal
 */
+ (RACSignal *)shareKnowledgeWithClass_two_id:(NSString *)class_two_id wiki_text:(NSString *)wiki_text fix_plan:(NSString *)fix_plan;

@end
