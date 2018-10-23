//
//  DKOrderViewModel.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderViewModel.h"
#import "DKOrderService.h"

@interface DKOrderViewModel ()
@property (nonatomic, strong) NSArray<DKOrderList *> *orderList;    // 订单列表
@property (nonatomic, strong) RACCommand *fetchOrderListCommand;     // 获取订单列表
@property (nonatomic, strong) RACCommand *fetchWorkStatusCommand; // 获取工程师上班状态
@end

@implementation DKOrderViewModel
- (RACCommand *)loadDataCommand
{
    return self.fetchOrderListCommand;
}

- (NSArray<RACCommand *> *)commands
{
    return @[self.fetchOrderListCommand,
             self.fetchWorkStatusCommand
             ];
}

- (RACCommand *)fetchWorkStatusCommand
{
    if (!_fetchWorkStatusCommand) {
        _fetchWorkStatusCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [DKOrderService fetchWorkStates];
        }];
    }
    return _fetchWorkStatusCommand;
}

- (RACCommand *)fetchOrderListCommand
{
    if (!_fetchOrderListCommand) {
        _fetchOrderListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[DKOrderService fetchOrderListWithStatus:self.orderType page:input num:DKPageSize] map:^id(id value) {
                if ([input integerValue] > 1) {
                    if (![value count]) [self.noMoreSubject sendNext:nil];
                    value = [self.orderList arrayByAddingObjectsFromArray:value];
                }
                return value;
            }];
        }];
    }
    return _fetchOrderListCommand;
}



- (void)setup
{
    [super setup];
    @weakify(self);
    [self.fetchOrderListCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.orderList = x;
    }];
}
@end
