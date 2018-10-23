//
//  DKScheduleCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKScheduleCell.h"

@interface DKScheduleCell()

@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *createOrderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointTimeLabel;

@end

@implementation DKScheduleCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.backGroundView dk_addShadowToView];
    
    return cell;
}

- (void)setDayCalendar:(DKDayCalendar *)dayCalendar
{
    _dayCalendar = dayCalendar;
    self.orderNumberLabel.text = dayCalendar.order_id;
    self.addressLabel.text = dayCalendar.contact_address;
    self.createOrderTimeLabel.text = [dayCalendar.order_create_time dk_dateTimeWithLonglongTimeFormat:@"yyyy-MM-dd HH:mm"];
    self.appointTimeLabel.text = [dayCalendar.appoint_time dk_dateTimeWithLonglongTimeFormat:@"yyyy-MM-dd HH:mm"];

}

@end
