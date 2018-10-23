//
//  DKBadgeView.m
//  传智微博
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DKBadgeView.h"

#define DKBadgeViewFont [UIFont systemFontOfSize:9]

@implementation DKBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        
        // 设置字体大小
        self.titleLabel.font = DKBadgeViewFont;
        
        [self sizeToFit];
        
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    // 判断badgeValue是否有内容
    if (!badgeValue.length) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    
//    [self setBackgroundImage:[UIImage imageNamed:@"nav_label_notwork"] forState:UIControlStateNormal];
//    [self setBackgroundColor:DKColorFontGray];
//    [self setTitle:badgeValue forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"nav_label_notwork"] forState:UIControlStateNormal];
}

@end
