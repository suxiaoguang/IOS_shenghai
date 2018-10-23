//
//  DKAccemptOrderViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewController.h"

typedef void(^DKDealOrderBlock)(BOOL isDeal);

@interface DKAccemptOrderViewController : DKViewController

/** 订单id */
@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, strong) DKDealOrderBlock dealBlock;

@end
