//
//  DKOrderService.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderService.h"

#import "DKOrderList.h"
#import "DKOrder.h"
#import "DKOrderStaff.h"
#import "DKOrderWikiFirst.h"

@implementation DKOrderService

// 获取订单管理列表
+ (RACSignal *)fetchOrderListWithStatus:(NSInteger)status page:(NSNumber *)page num:(NSInteger)num
{
    NSDictionary *params = @{@"status":@(status),
                             @"page_index":page,
                             @"page_size":@(num)
                             };
    return [DKNetworkManager.post(@"Order/index").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            NSArray<DKOrderList *> *orderList = [DKOrderList mj_objectArrayWithKeyValuesArray:response.data[@"order_list"]];
            return [RACSignal return:orderList];
        }
    }];
}

// 获取订单详情
+ (RACSignal *)fetchOrderDetailWithOrderId:(NSString *)orderId
{
    NSDictionary *params = @{@"order_id":orderId
                             };
    return [DKNetworkManager.post(@"Order/show").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            DKOrder *order = [DKOrder mj_objectWithKeyValues:response.data[@"order_info"]];
            return [RACSignal return:order];
        }
    }];
}

// 处理订单
+ (RACSignal *)dealOrderWithOrderId:(NSString *)orderId
{
    NSDictionary *params = @{@"order_id":DKNonnullString(orderId)
                             };
    return [DKNetworkManager.post(@"Order/start").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}


// 预约订单
+ (RACSignal *)appointOrderWithOrderId:(NSString *)orderId appointTime:(NSString *)appointTime
{
    NSDictionary *params = @{@"order_id":DKNonnullString(orderId),
                             @"appoint_time":DKNonnullString(appointTime)
                             };
    return [DKNetworkManager.post(@"Order/appoint").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 暂停订单
+ (RACSignal *)pauseOrderWithOrderId:(NSString *)orderId reason:(NSString *)reason
{
    NSDictionary *params = @{@"order_id":DKNonnullString(orderId),
                             @"reason":DKNonnullString(reason)
                             };
    return [DKNetworkManager.post(@"Order/pause").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 取消暂停订单
+ (RACSignal *)cancelPauseOrderWithOrderId:(NSString *)orderId
{
    NSDictionary *params = @{@"order_id":DKNonnullString(orderId)
                             };
    return [DKNetworkManager.post(@"Order/cancelPause").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 取消订单
+ (RACSignal *)cancelOrderWithOrderId:(NSString *)orderId reason:(NSString *)reason isCanResume:(NSString *)isCanResume
{
    NSDictionary *params = @{@"order_id":DKNonnullString(orderId),
                             @"reason":DKNonnullString(reason),
                             @"can_resume":DKNonnullString(isCanResume)
                             };
    return [DKNetworkManager.post(@"Order/cancelOrder").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 完成订单
+ (RACSignal *)completeOrderWithOrderId:(NSString *)orderId
                                 weakId:(NSString *)weakId
                              questType:(NSString *)questType
                                fixPlan:(NSString *)fixPlan
                           solutionType:(NSString *)solutionType
                         solutionRestlt:(NSString *)solutionResult
						   user_company:(NSString *)user_company
{
    NSDictionary *params = @{@"order_id":DKNonnullString(orderId),
                             @"wiki_id":DKNonnullString(weakId),
                             @"quest_type":DKNonnullString(questType),
                             @"fix_plan":DKNonnullString(fixPlan),
                             @"solution_type":DKNonnullString(solutionType),
                             @"solution_result":DKNonnullString(solutionResult),
							 @"user_company":DKNonnullString(user_company)
                             };
    return [DKNetworkManager.post(@"Order/complete").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 转派订单
+ (RACSignal *)turnOrderWithOrderId:(NSString *)orderId staffId:(NSString *)staffId
{
    NSDictionary *params = @{@"order_id":DKNonnullString(orderId),
                             @"staff_id":DKNonnullString(staffId)
                             };
    return [DKNetworkManager.post(@"Order/turn").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 获取订单知识库
+ (RACSignal *)fetchOrderWikiList
{
    return [DKNetworkManager.post(@"Order/wikiIndex").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            NSMutableArray<DKOrderWikiFirst *> *orderWikis = [DKOrderWikiFirst mj_objectArrayWithKeyValuesArray:response.data[@"wiki_list"]];
            return [RACSignal return:orderWikis];
        }
    }];
}

// 获取转诊同事列表
+ (RACSignal *)fetchStaffList
{
    return [DKNetworkManager.post(@"Order/staffIndex").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            NSArray<DKOrderStaff *> *orderStaffs = [DKOrderStaff
             mj_objectArrayWithKeyValuesArray:response.data[@"staff_list"]];
            return [RACSignal return:orderStaffs];
        }
    }];
}

// 获取工程师上班状态
+ (RACSignal *)fetchWorkStates
{
    return [DKNetworkManager.post(@"Staff/workingStatus").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:response.data[@"is_working"]];
        }
    }];
}

// 分享知识库
+ (RACSignal *)shareKnowledgeWithClass_two_id:(NSString *)class_two_id wiki_text:(NSString *)wiki_text fix_plan:(NSString *)fix_plan
{
	NSDictionary *params = @{@"class_two_id":DKNonnullString(class_two_id),
							 @"wiki_text":DKNonnullString(wiki_text),
							 @"fix_plan":DKNonnullString(fix_plan)
							 };
	return [DKNetworkManager.post(@"Wiki/store").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
		DKHttpResponse *response = tuple.second;
		if (response.error) {
			return [RACSignal error:response.error];
		} else {
			return [RACSignal return:@YES];
		}
	}];
}

@end
