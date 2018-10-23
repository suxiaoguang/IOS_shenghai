//
//  DKProblemTypeCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProblemTypeCell.h"

@interface DKProblemTypeCell ()

@property (weak, nonatomic) IBOutlet UIView *shawdowBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DKProblemTypeCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKProblemTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.shawdowBackgroundView dk_addShadowToView];
    
    return cell;
}

- (void)setOrderWikiFirst:(DKOrderWikiFirst *)orderWikiFirst
{
    _orderWikiFirst = orderWikiFirst;
    self.titleLabel.text = orderWikiFirst.text;
}

@end
