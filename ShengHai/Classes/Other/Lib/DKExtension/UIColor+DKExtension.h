//
//  UIColor+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/12/20 庄槟豪 on 15/12/15.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DKExtension)

/**
 随机颜色
 */
+ (UIColor *)dk_randomColor;

/**
 十六进制颜色

 @param color 十六进制颜色码
 @return  UIColor
 */
+ (UIColor *)dk_colorWithHexString:(NSString *)color;

/**
 从十六进制字符串获取颜色，
 color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式

 @param color  十六进制颜色码
 @param alpha 透明度
 @return  UIColor
 */
+ (UIColor *)dk_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
