//
//  DKContactArea.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/21.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKContactArea : NSObject

/** 大区 */
@property (nonatomic, copy) NSString *region_main;
/** 小区 */
@property (nonatomic, strong) NSArray<NSString *> *region_sub_list;

@end
