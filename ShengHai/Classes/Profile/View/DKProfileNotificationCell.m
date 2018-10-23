//
//  DKProfileNotificationCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileNotificationCell.h"

@interface DKProfileNotificationCell ()
@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation DKProfileNotificationCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKProfileNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setNotice:(DKNotice *)notice
{
    _notice = notice;
    self.messageContentLabel.text = notice.message_content;
    self.timeLabel.text = [notice.create_time dk_dateTimeWithLonglongTimeFormat:@"yyyy-MM-dd HH:mm"];
}

@end
