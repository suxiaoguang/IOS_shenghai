//
//  DKOrderCell.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKOrderList;

@interface DKOrderCell : UITableViewCell

@property (nonatomic, assign) DKOrderType orderType;

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/** 订单列表 */
@property (nonatomic, strong) DKOrderList *orderList;

@end
