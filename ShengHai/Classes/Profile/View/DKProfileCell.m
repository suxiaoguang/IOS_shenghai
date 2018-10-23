//
//  DKProfileCell.m
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/15.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileCell.h"

#import "DKProfileViewModel.h"

#define img(name) [UIImage imageNamed: name]

@interface DKProfileCell ()

@property (weak, nonatomic) IBOutlet UIImageView    *iconImageView; // 图标
@property (weak, nonatomic) IBOutlet UILabel        *titleLabel;    // 标题
@property (weak, nonatomic) IBOutlet UILabel        *rightLabel;    // 详细label

@end

@implementation DKProfileCell

+ (instancetype)cellWithTableView   :(UITableView *)tableView
                indexPath           :(NSIndexPath *)indexPath
                viewModel           :(DKProfileViewModel *)viewModel
{
    DKProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];

    cell = cell ? : DKLoadViewFromNib

        [cell.iconImageView setImage: img(viewModel.cellIcons[indexPath.row])];
    cell.titleLabel.text = viewModel.titles[indexPath.row];
    //    cell.rightLabel.text = indexPath.row == 0 ? DKUserInfoCache.tube_stage : @"";

    return cell;
}

@end
