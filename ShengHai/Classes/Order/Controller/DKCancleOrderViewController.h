//
//  DKCancleOrderViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewController.h"

typedef void(^DKCallBackBlock)(BOOL isCallBack);

@interface DKCancleOrderViewController : DKViewController

@property (nonatomic, strong) DKCallBackBlock callBackBlock;
/** 订单id */
@property (nonatomic, copy) NSString *orderId;

@end
