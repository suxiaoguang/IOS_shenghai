//
//  DKOrderDetailViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewController.h"

@interface DKOrderDetailViewController : DKViewController

@property (nonatomic, assign) DKOrderType orderType;
/** 订单id */
@property (nonatomic, copy) NSString *orderId;

@end
