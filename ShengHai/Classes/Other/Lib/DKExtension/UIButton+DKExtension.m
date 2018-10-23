//
//  UIButton+DKExtension.m
//  DKExtension
//
//  Created by Arclin on 16/12/31.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "UIButton+DKExtension.h"
#import <objc/runtime.h>

@implementation UIButton (DKExtension)

static char eventKey;

- (void)dk_handleControlEvent:(UIControlEvents)event withBlock:(ButtonClickedBlock)action {
    objc_setAssociatedObject(self, &eventKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(dk_callActionBlock:) forControlEvents:event];
}

- (void)dk_callActionBlock:(UIButton *)sender {
    ButtonClickedBlock block = (ButtonClickedBlock)objc_getAssociatedObject(self, &eventKey);
    if (block) {
        block(sender);
    }
}

@end
