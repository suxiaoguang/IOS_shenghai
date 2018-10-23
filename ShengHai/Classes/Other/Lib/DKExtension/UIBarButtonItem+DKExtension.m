//
//  UIBarButtonItem+DKExtension.m
//  DKExtension
//
//  Created by Arclin on 16/12/24.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "UIBarButtonItem+DKExtension.h"
#import "UIButton+DKExtension.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (DKExtension)

+ (instancetype)dk_itemForButtonWithImage:(UIImage *)image actionBlock:(DKBtnClickedBlock)block
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    CGRect rect = btn.frame;
    rect.size = CGSizeMake(20, 20);
    btn.frame = rect;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn dk_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        block(button);
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

@end
