//
//  DKProfileService.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileService.h"

#import "DKStaffContacts.h"
#import "DKOrderNumber.h"
#import "DKProfileStarInfo.h"
#import "DKStarInfoDetail.h"
#import "DKNotice.h"
#import "DKMonthCalendar.h"
#import "DKDayCalendar.h"
#import "DKContactInformation.h"
#import "DKOrderRemindCount.h"
#import "DKContactArea.h"

@implementation DKProfileService

// 退出登录
+ (RACSignal *)logout
{
    return [DKNetworkManager.post(@"Index/logout").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 上班
+ (RACSignal *)startWork
{
    return [DKNetworkManager.post(@"Staff/startWorking").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 下班
+ (RACSignal *)outWork
{
    return [DKNetworkManager.post(@"Staff/stopWorking").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 更新头像
+ (RACSignal *)updateHeadImage:(NSString *)headimgurl
{
    NSDictionary *params = @{@"headimgurl":DKNonnullString(headimgurl)
                             };
    return [DKNetworkManager.post(@"Staff/updateAvatar").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            DKUserInfo *userInfo = [DKUserInfo mj_objectWithKeyValues:response.data[@"staff_info"]];
            [userInfo cacheUserInfo:userInfo];
            return [RACSignal return:@YES];
        }
    }];
}

// 获取通讯录列表
+ (RACSignal *)fetchStaffList
{
    return [DKNetworkManager.post(@"Staff/contacts").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            NSArray<DKStaffContacts *> *staffContacts = [DKStaffContacts
                                                    mj_objectArrayWithKeyValuesArray:response.data[@"staff_list"]];
            return [RACSignal return:staffContacts];
        }
    }];
}

// 获取订单统计数量
+ (RACSignal *)fetchOrderNumber
{
    return [DKNetworkManager.post(@"Staff/orderStatistic").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            DKOrderNumber *orderNumber = [DKOrderNumber mj_objectWithKeyValues:response.data[@"statistic"]];
            return [RACSignal return:orderNumber];
        }
    }];
}


// 获取用户评分
+ (RACSignal *)fetchAccountScore
{
    return [DKNetworkManager.post(@"Staff/starInfo").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            DKProfileStarInfo *profileStarInfo = [DKProfileStarInfo mj_objectWithKeyValues:response.data];
            return [RACSignal return:profileStarInfo];
        }
    }];
}

// 获取用户评分列表
+ (RACSignal *)fetchAccountScoreListWithPage:(NSNumber *)page num:(NSInteger)num
{
    NSDictionary *params = @{@"page_index":page,
                             @"page_size":@(num)
                             };
    return [DKNetworkManager.post(@"Staff/commentIndex").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            NSArray<DKStarInfoDetail *> *starInfoDetail = [DKStarInfoDetail mj_objectArrayWithKeyValuesArray:response.data[@"comment_list"]];
            return [RACSignal return:starInfoDetail];
        }
    }];
}

// 获取用户评分详情
+ (RACSignal *)fetchStarInfoDetailWithOrderId:(NSString *)orderId
{
    NSDictionary *params = @{@"order_id":orderId
                             };
    return [DKNetworkManager.post(@"Staff/commentShow").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            DKStarInfoDetail *starInfoDetail = [DKStarInfoDetail mj_objectWithKeyValues:response.data[@"comment"]];
            return [RACSignal return:starInfoDetail];
        }
    }];
}

// 填写意见反馈
+ (RACSignal *)writeFeedbackWithContent:(NSString *)content
{
    NSDictionary *params = @{@"content":content
                             };
    return [DKNetworkManager.post(@"Staff/feedbackStore").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:@YES];
        }
    }];
}

// 获取消息通知列表
+ (RACSignal *)fetchNoticeListWithPage:(NSNumber *)page num:(NSInteger)num
{
    NSDictionary *params = @{@"page_index":page,
                             @"page_size":@(num)
                             };
    return [DKNetworkManager.post(@"Staff/messageIndex").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            NSArray<DKNotice *> *notices = [DKNotice mj_objectArrayWithKeyValuesArray:response.data[@"message_list"]];
            return [RACSignal return:notices];
        }
    }];
}

// 获取消息通知未读数
+ (RACSignal *)fetchNoticeUnread
{
    return [DKNetworkManager.post(@"Staff/hasUnreadMessage").params(nil).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:response.data[@"unread"]];
        }
    }];
}

// 获取工程师日程
+ (RACSignal *)fetchMonthCalendarWithYear:(NSString *)year month:(NSString *)month
{
    NSDictionary *params = @{@"year":year,
                             @"month":month
                             };
    return [DKNetworkManager.post(@"Staff/getMonthCalendar").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            DKMonthCalendar *monthCalendar = [DKMonthCalendar mj_objectWithKeyValues:response.data];
            return [RACSignal return:monthCalendar];
        }
    }];
}

// 获取日程列表
+ (RACSignal *)fetchDayCalendarListWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day
{
    NSDictionary *params = @{@"year":year,
                             @"month":month,
                             @"day":day
                             };
    return [DKNetworkManager.post(@"Staff/getDayCalendar").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            NSArray<DKDayCalendar *> *monthCalendars = [DKDayCalendar mj_objectArrayWithKeyValuesArray:response.data[@"order_list"]];
            return [RACSignal return:monthCalendars];
        }
    }];
}

// 获取常见问题
+ (RACSignal *)fetchQuestions
{
    return [DKNetworkManager.post(@"Index/questions").executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:response.data[@"content"]];
        }
    }];
}

// 获取平台规则
+ (RACSignal *)fetchRules
{
    return [DKNetworkManager.post(@"Index/rules").executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            return [RACSignal return:response.data[@"content"]];
        }
    }];
}

// 获取联系方式
+ (RACSignal *)fetchContactInformation
{
    return [DKNetworkManager.post(@"Index/csInfo").executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
        DKHttpResponse *response = tuple.second;
        if (response.error) {
            return [RACSignal error:response.error];
        } else {
            DKContactInformation *contactInformation = [DKContactInformation mj_objectWithKeyValues:response.data];
            return [RACSignal return:contactInformation];
        }
    }];
}

// 获取订单提醒数量
+ (RACSignal *)fetchOrderRemindCount
{
	return [DKNetworkManager.post(@"Order/indexCount").executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
		DKHttpResponse *response = tuple.second;
		if (response.error) {
			return [RACSignal error:response.error];
		} else {
			DKOrderRemindCount *orderRemindCount = [DKOrderRemindCount mj_objectWithKeyValues:response.data];
			return [RACSignal return:orderRemindCount];
		}
	}];
}

// 获取联系人地区
+ (RACSignal *)fetchContactAreaList
{
	return [DKNetworkManager.post(@"Index/regionIndex").executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
		DKHttpResponse *response = tuple.second;
		if (response.error) {
			return [RACSignal error:response.error];
		} else {
			NSArray<DKContactArea *> *contactAreas = [DKContactArea mj_objectArrayWithKeyValuesArray:response.data[@"region_list"]];
			return [RACSignal return:contactAreas];
		}
	}];
}

// 获取小区域联系人
+ (RACSignal *)fetchContactPeopleListWithMainArea:(NSString *)mainArea subArea:(NSString *)subArea
{
	NSDictionary *params = @{@"region_main":DKNonnullString(mainArea),
							 @"region_sub":DKNonnullString(subArea)
							 };
	return [DKNetworkManager.post(@"Staff/regionContacts").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
		DKHttpResponse *response = tuple.second;
		if (response.error) {
			return [RACSignal error:response.error];
		} else {
			NSArray<DKStaffContacts *> *staffContacts = [DKStaffContacts
														 mj_objectArrayWithKeyValuesArray:response.data[@"staff_list"]];
			return [RACSignal return:staffContacts];
		}
	}];
}

// 搜索联系人
+ (RACSignal *)searchContactWithKeyWord:(NSString *)keyword
{
	NSDictionary *params = @{@"keyword":DKNonnullString(keyword)
							 };
	return [DKNetworkManager.post(@"Staff/searchContacts").params(params).executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
		DKHttpResponse *response = tuple.second;
		if (response.error) {
			return [RACSignal error:response.error];
		} else {
			NSArray<DKStaffContacts *> *staffContacts = [DKStaffContacts
														 mj_objectArrayWithKeyValuesArray:response.data[@"staff_list"]];
			return [RACSignal return:staffContacts];
		}
	}];
}

@end
