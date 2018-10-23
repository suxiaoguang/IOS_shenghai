//
//  DKOrderUserInfoView.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderUserInfoView.h"

@interface DKOrderUserInfoView ()

@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;

@property (weak, nonatomic) IBOutlet UILabel *staffCodeLabel;  // 工号

@end

@implementation DKOrderUserInfoView

- (void)setOrder:(DKOrder *)order
{
    // 工号
    self.staffCodeLabel.text = order.staff_json_code;

    self.customerNameLabel.text = DKNonnullString(order.contact_name);
    self.customerPhoneLabel.text = DKNonnullString(order.contact_phone);
    self.customerAddressLabel.text = DKNonnullString(order.contact_address);
    self.orderTimeLabel.text = [order.order_create_time dk_dateTimeWithLonglongTimeFormat:@"yyyy-MM-dd HH:mm"];
}

- (IBAction)clickContact {
}
@end
