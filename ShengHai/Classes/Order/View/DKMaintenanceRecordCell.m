//
//  DKMaintenanceRecordCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/4.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKMaintenanceRecordCell.h"

#import <YYText/YYText.h>

@interface DKMaintenanceRecordCell ()

@property (weak, nonatomic) IBOutlet UIView     *topLineView; // 顶部横线
@property (weak, nonatomic) IBOutlet UIView     *middleCircleView;
@property (weak, nonatomic) IBOutlet UILabel    *attributeLabel;

@end

@implementation DKMaintenanceRecordCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKMaintenanceRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];

    cell = cell ? : DKLoadViewFromNib
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0) {
        cell.topImageView.hidden = NO;
        cell.topLineView.hidden = YES;
    }

    return cell;
}

- (void)setOrderRecord:(DKOrderRecord *)orderRecord
{
    _orderRecord = orderRecord;

    self.attributeLabel.attributedText = orderRecord.contentText;
}

@end
