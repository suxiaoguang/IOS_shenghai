//
//  DKDealWayWikiViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewController.h"

@interface DKDealWayWikiViewController : DKViewController

@property (nonatomic, copy) NSString *dealWayText;

/** 订单知识库列表 */
@property (nonatomic, strong) NSMutableArray<DKOrderWikiFirst *> *orderWikis;
/** 父行数 */
@property (nonatomic, assign) NSInteger parentRow;
/** 二级(儿子)行数 */
@property (nonatomic, assign) NSInteger childRow;
/** 孙子行数 */
@property (nonatomic, assign) NSInteger grandsonRow;

@end
