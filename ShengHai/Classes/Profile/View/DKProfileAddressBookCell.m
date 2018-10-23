//
//  DKProfileAddressBookCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileAddressBookCell.h"

@interface DKProfileAddressBookCell ()

@property (weak, nonatomic) IBOutlet UIView *shawdowBackgroundView;

@end

@implementation DKProfileAddressBookCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKProfileAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.shawdowBackgroundView dk_addShadowToView];
    
    return cell;
}

@end
