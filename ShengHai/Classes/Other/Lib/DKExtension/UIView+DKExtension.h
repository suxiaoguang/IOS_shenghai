//
//  UIView+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/7/8 庄槟豪 on 16/7/27.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DKExtension)

#pragma mark - frame extension

@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

#pragma mark - 添加xib配置属性
/** 边框颜色 */
@property (nonatomic, strong) IBInspectable UIColor *BorderColor;
/** 边框宽度 */
@property (nonatomic, assign) IBInspectable CGFloat BorderWidth;
/** 圆角半径 */
@property (nonatomic, assign) IBInspectable CGFloat CornerRadius;
/** 完全圆角 - 高度与屏幕高度的比例 */
@property (nonatomic, assign) IBInspectable CGFloat RadiusScopeH;
/** 完全圆角 正方形时，宽度与屏幕宽度的比例 */
@property (nonatomic, assign) IBInspectable CGFloat RadiusScopeW;

/**
 深复制 View
 
 @return 新的 View
 */
- (UIView *)dk_duplicate;

/**
 给View添加阴影
 */
- (void)dk_addShadowToView;

/**
 添加毛玻璃效果
 
 @param effcet 添加的样式
 */
- (void)dk_addBlurEffectStyle:(UIBlurEffectStyle)effcet;

/**
 添加圆角边框
 
 @param cornerRadius 圆角角度
 @param width 边框宽度
 @param color 边框颜色
 */
- (void)dk_addCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

/**
 判断两个View是否有交集
 
 @param view 另一个 view
 @return YES/NO
 */
- (BOOL)dk_intersectWithView:(UIView *)view;

/**
 截屏
 
 @param afterUpdates 视图加载完成后截图
 @return 截屏 View
 */
- (UIView *)dk_snapshotViewAfterScreenUpdates:(BOOL)afterUpdates;

@end
