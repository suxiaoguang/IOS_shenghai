//
//  UINavigationController+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/10/31.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (DKExtension)

/**
 导航条背景颜色和前景颜色

 @param foregroundColor 前景颜色
 @param backgroundColor 背景颜色
 */
- (void)dk_setBarForegroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor;

@end
