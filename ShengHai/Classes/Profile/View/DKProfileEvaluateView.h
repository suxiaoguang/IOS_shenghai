//
//  DKProfileEvaluateView.h
//  Logistics
//
//  Created by nanzeng liu on 2017/2/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKProfileEvaluateView : UIView

+ (instancetype)evaluateView;

@property (weak, nonatomic) IBOutlet UIButton *oneStarButton;
@property (weak, nonatomic) IBOutlet UIButton *twoStarButton;
@property (weak, nonatomic) IBOutlet UIButton *threeStarButton;
@property (weak, nonatomic) IBOutlet UIButton *fourStarButton;
@property (weak, nonatomic) IBOutlet UIButton *fiveStarButton;

@property (nonatomic, assign) CGFloat index;

@end
