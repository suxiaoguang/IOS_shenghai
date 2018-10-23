//
//  DKOrderEngineerView.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderEngineerView.h"

@interface DKOrderEngineerView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointmentTime;
@end

@implementation DKOrderEngineerView

- (void)setOrder:(DKOrder *)order
{
    self.nameLabel.text = order.staff_name;
    self.phoneLabel.text = order.staff_phone;
    self.appointmentTime.text = [order.appoint_time dk_dateTimeWithLonglongTimeFormat:@"yyyy-MM-dd HH:mm"];
}

@end
