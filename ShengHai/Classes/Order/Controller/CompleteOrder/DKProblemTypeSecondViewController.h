//
//  DKProblemTypeSecondViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKTableViewController.h"

#import "DKProblemTypeViewController.h"

#import "DKOrderWikiSecond.h"

@interface DKProblemTypeSecondViewController : DKTableViewController

@property (nonatomic, strong) DKProblemTypeCallBackBlock callBackBlock;

/** 是否分享 */
@property (nonatomic, assign) BOOL isShare;
/** 订单知识库列表 */
@property (nonatomic, strong) NSMutableArray<DKOrderWikiFirst *> *orderWikis;
/** 父行数 */
@property (nonatomic, assign) NSInteger parentRow;

/** 标题 */
@property (nonatomic, copy) NSString *navgationTitle;

@property (nonatomic, strong) NSArray<DKOrderWikiSecond *> *orderWikiSecond;

@end
