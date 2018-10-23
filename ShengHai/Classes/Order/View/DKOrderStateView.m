//
//  DKOrderStateView.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderStateView.h"

@interface DKOrderStateView ()
@property (weak, nonatomic) IBOutlet UIImageView *orderStateImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderWaitStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitTimeLabel;

@property(nonatomic,retain) dispatch_source_t timer;
@property (nonatomic, assign) NSInteger countDown;
@end

@implementation DKOrderStateView

- (void)setOrder:(DKOrder *)order
{
    switch (self.orderType) {
        case DKOrderTypeWait: { // 未接单
            self.orderWaitStateLabel.hidden = NO;
            self.waitTimeLabel.hidden = NO;
            self.orderStateLabel.hidden = YES;
			self.orderStateImageView.image = [UIImage imageNamed:@"pic_order_waiting"];
			self.orderWaitStateLabel.text = [NSString dk_stringWithFormat:@"订单 %@ 未接单",order.order_id];
			
            self.countDown = [[NSDate date] timeIntervalSince1970] - order.order_create_time.integerValue;
            @weakify(self);
            [self countDownWithPER_SECBlock:^{
                @strongify(self);
                self.countDown += 1;
                NSInteger hour = self.countDown / 3600;
                NSInteger m = (self.countDown - hour * 3600) / 60;
                NSInteger s = self.countDown - hour * 3600 - m * 60;
                self.waitTimeLabel.text = [NSString dk_stringWithFormat:@"响应时间 %ld:%ld:%ld", (long)hour, (long)m, (long)s];
            }];
            break;
        }
        case DKOrderTypeDeal: { // 处理中
            [self setUpOrderImageName:@"pic_order_working" orderStateText:[NSString dk_stringWithFormat:@"订单 %@ 正在处理",order.order_id]];
            break;
        }
        case DKOrderTypeHang: { // 已挂起
            [self setUpOrderImageName:@"pic_order_waiting" orderStateText:[NSString dk_stringWithFormat:@"订单 %@ 已暂停",order.order_id]];
            break;
        }
        case DKOrderTypeTurnSend: { // 已转派
            
            break;
        }
        case DKOrderTypeComplete: { // 已完成
            if ([order.status_text isEqualToString:@"已完成"]) {
                [self setUpOrderImageName:@"pic_order_finished" orderStateText:[NSString dk_stringWithFormat:@"订单 %@ 已完成",order.order_id]];
            } else if ([order.status_text isEqualToString:@"已关闭"]) {
                [self setUpOrderImageName:@"pic_order_closed" orderStateText:[NSString dk_stringWithFormat:@"订单 %@ 已关闭",order.order_id]];
            }

            break;
        }
    }
}

// 设置订单状态
- (void)setUpOrderImageName:(NSString *)imageName orderStateText:(NSString *)orderStateText
{
    self.orderStateImageView.image = [UIImage imageNamed:imageName];
    self.orderStateLabel.text = orderStateText;
}

// 每秒走一次回调
- (void)countDownWithPER_SECBlock:(void (^)())PER_SECBlock
{
    if (_timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                PER_SECBlock();
            });
        });
        dispatch_resume(_timer);
    }
}

@end
