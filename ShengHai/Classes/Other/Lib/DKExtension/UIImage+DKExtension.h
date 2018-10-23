//
//  UIImage+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/11/1 庄槟豪 on 15/11/17.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DKExtension)

/**
 改变图片尺寸（给定宽度，高度按比例计算）

 @param sourceImage 原图
 @param targetWidth 目标图片宽度
 @return 压缩后的图片
 */
+ (UIImage *)dk_compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;

/**
 创建一个内容可拉伸，而边角不拉伸的图片
 
 @param imageName 图片名
 @return 图片
 */
+ (instancetype)dk_imageWithStretchableName:(NSString *)imageName;

/**
 *  把图片裁剪成带有圆环的圆形图片
 *
 *  @param image       原图片
 *  @param borderWidth 圆环的宽度
 *  @param borderColor 圆环的颜色
 *
 *  @return 带有圆环的圆形图片
 */
+ (instancetype)dk_imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 保存图片至沙盒

 @param image 图片
 @param imageName 图片名
 @return 路径
 */
+ (NSString *)dk_saveImage:(UIImage *)image withName:(NSString *)imageName;

@end
