//
//  DKOrderCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderCell.h"

#import "DKOrderList.h"

@interface DKOrderCell ()

@property (weak, nonatomic) IBOutlet UIView     *backGroundView;
@property (weak, nonatomic) IBOutlet UILabel    *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel    *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel    *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel    *orderTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *bageView; // 左上角小圆圈

@end

@implementation DKOrderCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.backGroundView dk_addShadowToView];
    
    return cell;
}

- (void)setOrderList:(DKOrderList *)orderList
{
    _orderList = orderList;
    self.stateLabel.text = orderList.status_text;
    self.orderTimeLabel.text = [orderList.order_create_time dk_dateTimeWithLonglongTimeFormat:@"yyyy-MM-dd HH:mm"];
    self.orderNumberLabel.text = orderList.order_id;
    self.addressLabel.text = orderList.contact_address;
    
    switch (self.orderType) {
        case DKOrderTypeWait: { // 未接单
            
            break;
        }
        case DKOrderTypeDeal: { // 处理中
            self.stateLabel.textColor = DKColorTintMain;
            self.bageView.backgroundColor = DKColorTintMain;
            break;
        }
        case DKOrderTypeHang: { // 已挂起
            
            break;
        }
        case DKOrderTypeTurnSend: { // 已转派
            self.stateLabel.textColor = DKColorFontGray;
            self.bageView.backgroundColor = DKColorLineGray;
            break;
        }
        case DKOrderTypeComplete: { // 已完成
            self.stateLabel.textColor = DKColorFontGray;
            self.bageView.backgroundColor = DKColorLineGray;
            break;
        }
    }

}

@end
