//
//  DKProfileGradeCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/25.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileGradeCell.h"

@interface DKProfileGradeCell ()

@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation DKProfileGradeCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKProfileGradeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.backGroundView dk_addShadowToView];
    
    return cell;
}

- (void)setStarInfoDetail:(DKStarInfoDetail *)starInfoDetail
{
    _starInfoDetail = starInfoDetail;
    if ([starInfoDetail.comment_has_read isEqualToString:@"1"]) {
        self.detailLabel.textColor = DKColorFontGray;
    } else {
        self.detailLabel.textColor = DKColorFontDarkGray;
    }
}

@end
