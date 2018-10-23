//
//  DKOrderTurnStaffCell.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKOrderStaff.h"

@interface DKOrderTurnStaffCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/** 同事 */
@property (nonatomic, strong) DKOrderStaff *orderStaff;

@end
