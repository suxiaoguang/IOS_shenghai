//
//  DKOrderDetailViewModel.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderDetailViewModel.h"

#import "DKOrderService.h"

#import "DKOrder.h"
#import "DKOrderWikiFirst.h"
#import "DKOrderStaff.h"

@interface DKOrderDetailViewModel ()
@property (nonatomic, strong) DKOrder                   *order;         // 订单详情
@property (nonatomic, strong) NSArray <DKOrderStaff *>  *orderStaffs;   // 订单转诊同事列表

@property (nonatomic, strong) RACCommand    *fetchOrderDetailCommand;   // 获取订单详情
@property (nonatomic, strong) RACCommand    *cancelPauseCommand;        // 取消暂停命令
@property (nonatomic, strong) RACCommand    *dealOrderCommand;          // 立即处理订单
@property (nonatomic, strong) RACCommand    *appointOrderCommand;       // 预约订单
@property (nonatomic, strong) RACCommand    *pauseOrderCommand;         // 暂停订单
@property (nonatomic, strong) RACCommand    *cancelOrderCommand;        // 取消订单
@property (nonatomic, strong) RACCommand    *completeOrderCommand;      // 完成订单
@property (nonatomic, strong) RACCommand    *turnOrderCommand;          // 转派订单
@property (nonatomic, strong) RACCommand    *fetchOrderWikiListCommand; // 获取订单知识库
@property (nonatomic, strong) RACCommand    *fetchStaffListCommand;     // 获取转诊同事列表
@property (nonatomic, strong) RACCommand    *shareKnowledgeCommand;     // 分享知识库
@end

@implementation DKOrderDetailViewModel

- (NSArray<RACCommand *> *)commands
{
    return @[self.fetchOrderDetailCommand,
             self.cancelPauseCommand,
             self.dealOrderCommand,
             self.appointOrderCommand,
             self.pauseOrderCommand,
             self.cancelOrderCommand,
             self.completeOrderCommand,
             self.turnOrderCommand,
             self.fetchOrderWikiListCommand,
             self.fetchStaffListCommand,
			 self.shareKnowledgeCommand
			 ];
}

// 分享知识库
- (RACCommand *)shareKnowledgeCommand
{
	if (!_shareKnowledgeCommand) {
		@weakify(self);
		_shareKnowledgeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
			@strongify(self);
			return [DKOrderService shareKnowledgeWithClass_two_id:self.weakId wiki_text:self.questType fix_plan:self.fixPlan];
		}];
	}
	return _shareKnowledgeCommand;
}

// 获取订单详情
- (RACCommand *)fetchOrderDetailCommand
{
    if (!_fetchOrderDetailCommand) {
        _fetchOrderDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *orderId) {
            return [[DKOrderService fetchOrderDetailWithOrderId:orderId] map:^id(id value) {
                self.order = value;
                return value;
            }];
        }];
    }
    return _fetchOrderDetailCommand;
}

// 取消暂停
- (RACCommand *)cancelPauseCommand
{
    if (!_cancelPauseCommand) {
        @weakify(self);
        _cancelPauseCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [DKOrderService cancelPauseOrderWithOrderId:self.orderId];
        }];
    }
    return _cancelPauseCommand;
}

// 立即处理订单
- (RACCommand *)dealOrderCommand
{
    if (!_dealOrderCommand) {
        @weakify(self);
        _dealOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [DKOrderService dealOrderWithOrderId:self.orderId];
        }];
    }
    return _dealOrderCommand;
}

// 预约订单
- (RACCommand *)appointOrderCommand
{
    if (!_appointOrderCommand) {
        @weakify(self);
        _appointOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [DKOrderService appointOrderWithOrderId:self.orderId appointTime:self.appointTime];
        }];
    }
    return _appointOrderCommand;
}

// 暂停订单
- (RACCommand *)pauseOrderCommand
{
    if (!_pauseOrderCommand) {
        @weakify(self);
        _pauseOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [DKOrderService pauseOrderWithOrderId:self.orderId reason:self.pauseReason];
        }];
    }
    return _pauseOrderCommand;
}

// 取消订单
- (RACCommand *)cancelOrderCommand
{
    if (!_cancelOrderCommand) {
        @weakify(self);
        _cancelOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [DKOrderService cancelOrderWithOrderId:self.orderId reason:self.canleReason isCanResume:self.isCanResume];
        }];
    }
    return _cancelOrderCommand;
}

// 完成订单
- (RACCommand *)completeOrderCommand
{
    if (!_completeOrderCommand) {
        @weakify(self);
        _completeOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
			return [DKOrderService completeOrderWithOrderId:self.orderId weakId:self.weakId questType:self.questType fixPlan:self.fixPlan solutionType:self.solutionType solutionRestlt:self.solutionResult user_company:self.user_company];
        }];
    }
    return _completeOrderCommand;
}

// 转派订单
- (RACCommand *)turnOrderCommand
{
    if (!_turnOrderCommand) {
        @weakify(self);
        _turnOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [DKOrderService turnOrderWithOrderId:self.orderId staffId:self.staffId];
        }];
    }
    return _turnOrderCommand;
}

// 获取订单知识库
- (RACCommand *)fetchOrderWikiListCommand
{
    if (!_fetchOrderWikiListCommand) {
        @weakify(self);
        _fetchOrderWikiListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[DKOrderService fetchOrderWikiList] map:^id(NSMutableArray<DKOrderWikiFirst *> *orderWikis) {
				[orderWikis enumerateObjectsUsingBlock:^(DKOrderWikiFirst * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop) {
					[obj1.child enumerateObjectsUsingBlock:^(DKOrderWikiSecond * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop) {
						[DKGetOrderWikis[idx1].child[idx2].child enumerateObjectsUsingBlock:^(DKOrderWikiThird * _Nonnull obj3, NSUInteger idx, BOOL * _Nonnull stop) {
							if (!obj3.Id.length) {
								[obj2.child addObject:obj3];
							}
						}];
					}];
				}];
				DKSetCache(DKUserInfoCache.staff_id, orderWikis);
				self.orderWikis = DKGetOrderWikis;
                return orderWikis;
            }];
        }];
    }
    return _fetchOrderWikiListCommand;
}

// 获取转诊同事列表
- (RACCommand *)fetchStaffListCommand
{
    if (!_fetchStaffListCommand) {
        @weakify(self);
        _fetchStaffListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[DKOrderService fetchStaffList] map:^id(id value) {
                self.orderStaffs = value;
                return value;
            }];
        }];
    }
    return _fetchStaffListCommand;
}

@end
