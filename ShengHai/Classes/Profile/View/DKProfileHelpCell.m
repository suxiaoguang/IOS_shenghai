//
//  DKProfileHelpCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/21.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileHelpCell.h"

#import "DKProfileHelpViewModel.h"

@interface DKProfileHelpCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@end

@implementation DKProfileHelpCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath viewModel:(DKProfileHelpViewModel *)viewModel
{
    DKProfileHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    
    cell = cell ? : DKLoadViewFromNib
    
    cell.leftLabel.text = viewModel.titles[indexPath.row];
    //    cell.rightLabel.text = indexPath.row == 0 ? DKUserInfoCache.tube_stage : @"";
    
    return cell;
}

@end
