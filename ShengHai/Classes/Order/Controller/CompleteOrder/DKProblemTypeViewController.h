//
//  DKProblemTypeViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKTableViewController.h"

typedef void(^DKProblemTypeCallBackBlock)(NSString *callBackType,NSString *callBackText,NSString *weakId,
NSString *questType);

@interface DKProblemTypeViewController : DKTableViewController

@property (nonatomic, strong) DKProblemTypeCallBackBlock callBackBlock;
/** 是否分享 */
@property (nonatomic, assign) BOOL isShare;

@end
