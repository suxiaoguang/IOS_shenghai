//
//  DKOrderRemindCount.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/18.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKOrderRemindCount : NSObject

/** 待接受数量 */
@property (nonatomic, copy) NSString *count_wait;
/** 处理中数量 */
@property (nonatomic, copy) NSString *count_handle;
/** 已挂起数量 */
@property (nonatomic, copy) NSString *count_pause;
/** 已转派数量 */
@property (nonatomic, copy) NSString *count_turn;
/** 已完成数量 */
@property (nonatomic, copy) NSString *count_complete;

@end
