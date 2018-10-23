//
//  NSObject+DKExtension.h
//  DKExtension
//
//  Created by 庄槟豪 on 16/11/23.
//  Edited by Arclin on 16/12/30.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface UIViewController (DKExtension) <MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

/**
 弹出拨打电话视图

 @param phoneNum 电话号码
 */
- (void)dk_showPhoneViewWithPhoneNum:(NSString *)phoneNum;

/**
 弹出发送短信视图控制器

 @param phoneNum 电话号码
 */
- (void)dk_presentMessageViewControllerWithPhoneNum:(NSString *)phoneNum;


/**
 弹出发送电子邮件视图控制器
 
 @param emailAddrs 电子邮件地址(多个)
 @param subject 邮件标题
 @param body 邮件正文
 @param isHtml 正文是否以HTML格式发送
 */
- (void)dk_presentEmailViewControllerWithEmails:(NSArray<NSString *> *)emailAddrs subject:(NSString *)subject body:(NSString *)body isHTML:(BOOL)isHtml;

@end
