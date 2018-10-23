//
//  UINavigationController+DKExtension.m
//  DKExtension
//
//  Created by Arclin on 16/10/31.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "UINavigationController+DKExtension.h"

@implementation UINavigationController (DKExtension)

- (void)dk_setBarForegroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor
{
    // 导航条背景颜色
    self.navigationBar.barTintColor = backgroundColor;
    
    // 导航条title颜色
    NSMutableDictionary *barTitleDic = [NSMutableDictionary dictionary];
    barTitleDic[NSForegroundColorAttributeName] = foregroundColor;
    [self.navigationBar setTitleTextAttributes:barTitleDic];
}

@end
