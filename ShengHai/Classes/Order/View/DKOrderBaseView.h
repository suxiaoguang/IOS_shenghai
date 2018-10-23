//
//  DKOrderBaseView.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKView.h"

#import "DKOrder.h"

@interface DKOrderBaseView : DKView

@property (nonatomic, assign) DKOrderType orderType;

@property (nonatomic, strong) DKOrder *order;

@end
