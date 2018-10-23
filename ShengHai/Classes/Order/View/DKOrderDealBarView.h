//
//  DKOrderDealBarView.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/5.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKView.h"

@interface DKOrderDealBarView : DKView

@property (weak, nonatomic) IBOutlet UIButton *pauseButton; // 暂停按钮
@property (weak, nonatomic) IBOutlet UIButton *turnButton; // 转派按钮
@property (weak, nonatomic) IBOutlet UIButton *cancleOrderButton; // 取消订单按钮
@property (weak, nonatomic) IBOutlet UIButton *completeButton; // 确认订单按钮

@end
