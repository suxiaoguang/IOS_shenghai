//
//  DKProfileGradeCell.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/25.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DKStarInfoDetail.h"

@interface DKProfileGradeCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) DKStarInfoDetail *starInfoDetail;

@end
