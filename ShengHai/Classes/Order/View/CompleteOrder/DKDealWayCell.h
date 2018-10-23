//
//  DKDealWayCell.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKOrderWikiSecond.h"
#import "DKOrderWikiThird.h"

@interface DKDealWayCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath dataSources:(NSArray *)dataSources;

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) DKOrderWikiSecond *orderWikiSecond;

@property (nonatomic, strong) DKOrderWikiThird *orderWikiThird;

@end
