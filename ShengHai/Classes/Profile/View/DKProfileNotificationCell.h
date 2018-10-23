//
//  DKProfileNotificationCell.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DKNotice.h"

@interface DKProfileNotificationCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) DKNotice *notice;

@end
