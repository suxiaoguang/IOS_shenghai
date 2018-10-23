//
//  DKOrderDetailViewModel.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewModel.h"

@class DKOrder,DKOrderWikiFirst,DKOrderStaff;

@interface DKOrderDetailViewModel : DKViewModel

/** 订单id */
@property (nonatomic, copy) NSString *orderId;
/** 预约时间戳 */
@property (nonatomic, copy) NSString *appointTime;
/** 暂停原因 */
@property (nonatomic, copy) NSString *pauseReason;
/** 取消原因 */
@property (nonatomic, copy) NSString *canleReason;
/** 该订单否是能重新发起（传0，1） */
@property (nonatomic, copy) NSString *isCanResume;
/** 转派工程师id */
@property (nonatomic, copy) NSString *staffId;

// 完成订单
/** 知识库二级id */
@property (nonatomic, copy) NSString *weakId;
/** 问题类型（知识库3级的text） */
@property (nonatomic, copy) NSString *questType;
/** 解决方案（知识库3级的solution_plan，可编辑） */
@property (nonatomic, copy) NSString *fixPlan;
/** 解决方式（传0，1，2） */
@property (nonatomic, copy) NSString *solutionType;
/** 解决情况（传0，1，2） */
@property (nonatomic, copy) NSString *solutionResult;
/** 客户所在公司 */
@property (nonatomic, copy) NSString *user_company;

/** 订单详情 */
@property (nonatomic, strong, readonly) DKOrder *order;
/** 订单知识库列表 */
@property (nonatomic, strong) NSMutableArray<DKOrderWikiFirst *> *orderWikis;
/** 订单转诊同事列表 */
@property (nonatomic, strong, readonly) NSArray<DKOrderStaff *> *orderStaffs;

/** 获取订单详情 */
@property (nonatomic, strong, readonly) RACCommand *fetchOrderDetailCommand;
/** 取消暂停 */
@property (nonatomic, strong, readonly) RACCommand *cancelPauseCommand;
/** 立即处理订单 */
@property (nonatomic, strong, readonly) RACCommand *dealOrderCommand;
/** 预约订单 */
@property (nonatomic, strong, readonly) RACCommand *appointOrderCommand;
/** 暂停订单 */
@property (nonatomic, strong, readonly) RACCommand *pauseOrderCommand;
/** 取消订单 */
@property (nonatomic, strong, readonly) RACCommand *cancelOrderCommand;
/** 完成订单 */
@property (nonatomic, strong, readonly) RACCommand *completeOrderCommand;
/** 转派订单 */
@property (nonatomic, strong, readonly) RACCommand *turnOrderCommand;
/** 获取订单知识库 */
@property (nonatomic, strong, readonly) RACCommand *fetchOrderWikiListCommand;
/** 获取转诊同事列表 */
@property (nonatomic, strong, readonly) RACCommand *fetchStaffListCommand;
/** 分享知识库 */
@property (nonatomic, strong, readonly) RACCommand *shareKnowledgeCommand;


@end
