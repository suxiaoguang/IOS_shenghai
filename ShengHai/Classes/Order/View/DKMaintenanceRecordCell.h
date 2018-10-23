//
//  DKMaintenanceRecordCell.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/4.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DKOrderRecord.h"

@interface DKMaintenanceRecordCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (nonatomic, strong) DKOrderRecord *orderRecord;

@end
