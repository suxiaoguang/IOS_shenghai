//
//  DKDealEventViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKTableViewController.h"

typedef void(^DKCallBackBlock)(NSString *callBackNumber,NSString *callBackText);

@interface DKDealEventViewController : DKTableViewController

@property (nonatomic, strong) DKCallBackBlock callBackBlock;

@end
