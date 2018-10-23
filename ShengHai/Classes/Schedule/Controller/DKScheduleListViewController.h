//
//  DKScheduleListViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKTableViewController.h"

@interface DKScheduleListViewController : DKTableViewController

/** 标题 */
@property (nonatomic, copy) NSString *dateTitle;

/** 日期 */
@property (nonatomic, strong) NSDate *date;

@end
