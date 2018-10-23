//
//  DKProblemTypeThirdViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKTableViewController.h"

#import "DKProblemTypeViewController.h"

#import "DKOrderWikiThird.h"

@interface DKProblemTypeThirdViewController : DKTableViewController

@property (nonatomic, strong) DKProblemTypeCallBackBlock callBackBlock;

/** 一级标题-二级标题 */
@property (nonatomic, copy) NSString *twoTitle;
/** 二级Id */
@property (nonatomic, copy) NSString *secondWikiId;

/** 订单知识库列表 */
@property (nonatomic, strong) NSMutableArray<DKOrderWikiFirst *> *orderWikis;
/** 父行数 */
@property (nonatomic, assign) NSInteger parentRow;
/** 二级(儿子)行数 */
@property (nonatomic, assign) NSInteger childRow;

/** 标题 */
@property (nonatomic, copy) NSString *navgationTitle;

@property (nonatomic, strong) NSArray<DKOrderWikiThird *> *orderWikiThird;

@end
