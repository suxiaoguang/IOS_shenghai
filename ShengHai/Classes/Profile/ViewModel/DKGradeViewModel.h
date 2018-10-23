//
//  DKGradeViewModel.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewModel.h"

#import "DKStarInfoDetail.h"

@interface DKGradeViewModel : DKViewModel

/** 订单id */
@property (nonatomic, copy) NSString *orderId;

/** 评价列表数组 */
@property (nonatomic, strong, readonly) NSArray<DKStarInfoDetail *> *starInfoDetails;

/** 获取评价列表 */
@property (nonatomic, strong, readonly) RACCommand *fetchAccountScoreListCommand;
/** 获取评价详情 */
@property (nonatomic, strong, readonly) RACCommand *fetchStarInfoDetailCommand;

@end
