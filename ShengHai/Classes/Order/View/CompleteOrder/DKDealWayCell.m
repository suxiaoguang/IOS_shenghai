//
//  DKDealWayCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKDealWayCell.h"

@interface DKDealWayCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@end

@implementation DKDealWayCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath dataSources:(NSArray *)dataSources
{
    DKDealWayCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftLabel.text = dataSources[indexPath.row];
    
    return cell;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKDealWayCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setOrderWikiSecond:(DKOrderWikiSecond *)orderWikiSecond
{
    _orderWikiSecond = orderWikiSecond;
    self.leftLabel.text = orderWikiSecond.text;
}

- (void)setOrderWikiThird:(DKOrderWikiThird *)orderWikiThird
{
    _orderWikiThird = orderWikiThird;
    self.leftLabel.text = orderWikiThird.text;
}

@end
