//
//  DKOrderNumber.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKOrderNumber : NSObject

/** 月接单 */
@property (nonatomic, copy) NSString *month_accept;
/** 月完成 */
@property (nonatomic, copy) NSString *month_complete;
/** 周接单 */
@property (nonatomic, copy) NSString *week_accept;
/** 周完成 */
@property (nonatomic, copy) NSString *week_complete;
/** 月完成百分比 */
@property (nonatomic, copy) NSString *month_complete_percentage;
/** 周完成百分比 */
@property (nonatomic, copy) NSString *week_complete_percentage;
/** 总订单数 */
@property (nonatomic, copy) NSString *total_order;
/** 解决率 */
@property (nonatomic, copy) NSString *complete_percentage;
/** 响应率 */
@property (nonatomic, copy) NSString *accept_percentage;
/** 满意率 */
@property (nonatomic, copy) NSString *comment_good_percentage;

@end
