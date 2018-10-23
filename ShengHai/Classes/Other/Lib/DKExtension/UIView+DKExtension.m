//
//  UIView+DKExtension.m
//  DKExtension
//
//  Created by 庄槟豪 on 16/7/27.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "UIView+DKExtension.h"

@implementation UIView (DKExtension)

#pragma mark - frame extension

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

#pragma mark - 添加xib配置属性

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)BorderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)BorderWidth
{
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (CGFloat)CornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setRadiusScopeH:(CGFloat)scope
{
    CGFloat selfHeight = [UIScreen mainScreen].bounds.size.height * scope;
    [self setCornerRadius:selfHeight * 0.5];
}

- (void)setRadiusScopeW:(CGFloat)scope
{
    CGFloat selfHeight = [UIScreen mainScreen].bounds.size.width * scope;
    [self setCornerRadius:selfHeight * 0.5];
}

- (CGFloat)RadiusScopeW
{
    return 0; // just hide warning
}

- (CGFloat)RadiusScopeH
{
    return 0; // just hide warning
}

- (UIView *)dk_duplicate
{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (void)dk_addShadowToView
{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.1;//阴影透明度，默认0
    self.layer.shadowRadius = 4;//阴影半径，默认3
}

- (void)dk_addBlurEffectStyle:(UIBlurEffectStyle)style
{
    // 给背景添加毛玻璃效果
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.bounds;
    
    [self addSubview:visualEffectView];
}

- (void)dk_addCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (BOOL)dk_intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (UIView *)dk_snapshotViewAfterScreenUpdates:(BOOL)afterUpdates
{
    if([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.layer renderInContext:context];
        UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView *snapView = [[UIImageView alloc] initWithImage:targetImage];
        snapView.frame = self.frame;
        return snapView;
    }else {
        return [self snapshotViewAfterScreenUpdates:afterUpdates];
    }
}

@end
