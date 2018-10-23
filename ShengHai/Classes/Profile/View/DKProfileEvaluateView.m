//
//  DKProfileEvaluateView.m
//  Logistics
//
//  Created by nanzeng liu on 2017/2/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileEvaluateView.h"

@interface DKProfileEvaluateView ()

@property (nonatomic, strong) NSArray *buttonArray;

@end

@implementation DKProfileEvaluateView
- (NSArray *)buttonArray
{
    if (!_buttonArray.count) {
        _buttonArray = @[self.oneStarButton,self.twoStarButton,self.threeStarButton,self.fourStarButton,self.fiveStarButton];
    }
    return _buttonArray;
}

+ (instancetype)evaluateView
{
    return DKLoadViewFromNib;
}

- (void)setIndex:(CGFloat)index
{
    _index = index;
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx <= (NSInteger)index - 1) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.oneStarButton.tag = 0;
    self.twoStarButton.tag = 1;
    self.threeStarButton.tag = 2;
    self.fourStarButton.tag = 3;
    self.fiveStarButton.tag = 4;
}

- (IBAction)clickButton:(UIButton *)sender {
    self.index = sender.tag + 1;
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx <= sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }];
}

@end
