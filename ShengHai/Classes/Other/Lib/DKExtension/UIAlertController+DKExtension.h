//
//  UIAlertView+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/8/26.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DKAlertWithBtnBlock)(NSInteger index);
typedef void (^DKActionWithBtnBlock)(NSInteger index);
typedef void (^DKAlertWithTextBlock)(NSInteger index,NSString *text);

@interface UIAlertController (DKExtension)<UIAlertViewDelegate>

/**
 标题+信息+确认按钮
 
 @param title 标题
 @param message 显示信息
 */
+ (void)dk_alertWithOKButtonWithTitle:(NSString *)title message:(NSString *)message;

/** 标题+信息+确认+取消按钮 */
+ (void)dk_alertWithOKCancelBtnWithTitle:(NSString *)title message:(NSString *)message clickBtnAtIndex:(DKAlertWithBtnBlock)block;

/** 标题+信息+确认+取消+文本框 */
+ (void)dk_alertWithtPlainText:(NSString *)title isSecure:(BOOL)isSecure message:(NSString *)message placeholder:(NSString *)placehoder keyBoardType:(UIKeyboardType)keyBoardType clickBtnAtIndex:(DKAlertWithTextBlock)block;

/** 标题+信息+按钮A+...+按钮N */
+ (void)dk_alertWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(DKActionWithBtnBlock)block;

/** 列表：标题+信息+按钮A+...+按钮N */
+ (void)dk_actionSheetWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(DKActionWithBtnBlock)block;

@end
