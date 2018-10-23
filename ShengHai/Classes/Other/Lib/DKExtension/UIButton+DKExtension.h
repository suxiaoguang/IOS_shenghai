//
//  UIButton+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/12/31.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClickedBlock)(UIButton *button);

@interface UIButton (DKExtension)

/**
 UIButton 附加 Block 点击回调

 @param event 点击状态
 @param action 回调方法
 */
- (void)dk_handleControlEvent:(UIControlEvents)event withBlock:(ButtonClickedBlock)action;

@end
