//
//  UIBarButtonItem+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/12/24.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DKBtnClickedBlock)(UIButton *button);

@interface UIBarButtonItem (DKExtension)

/**
 拥有尺寸为20，20的图片的按钮

 @param image 图片
 @param block 点击回调
 @return UIBarButtonItem
 */
+ (instancetype)dk_itemForButtonWithImage:(UIImage *)image actionBlock:(DKBtnClickedBlock)block;

@end
