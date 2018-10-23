//
//  DKOrderTurnStaffCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderTurnStaffCell.h"

@interface DKOrderTurnStaffCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation DKOrderTurnStaffCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKOrderTurnStaffCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setOrderStaff:(DKOrderStaff *)orderStaff
{
    _orderStaff = orderStaff;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:orderStaff.headimgurl] placeholderImage:[UIImage imageNamed:@"ic_user"]];
    self.nameLabel.text = orderStaff.staff_name;
}

@end
