//
//  DKOrderViewModel.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewModel.h"

@class DKOrderList;

@interface DKOrderViewModel : DKViewModel

/** 订单列表 */
@property (nonatomic, strong, readonly) NSArray<DKOrderList *> *orderList;
/** 订单类型 */
@property (nonatomic, assign) DKOrderType orderType;

/** 获取订单管理列表命令 */
@property (nonatomic, strong, readonly) RACCommand *fetchOrderListCommand;
/** 获取工程师上班状态 */
@property (nonatomic, strong, readonly) RACCommand *fetchWorkStatusCommand;

@end
