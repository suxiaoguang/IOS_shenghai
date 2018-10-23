//
//  DKMacro.h
//  DKExtension
//
//  Created by 庄槟豪 on 2016/11/14  Arclin on 16/12/31.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

/*** 沙盒 ***/
#define DKHomePath        NSHomeDirectory()
#define DKTempPath        NSTemporaryDirectory()
#define DKDocumentPath    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/*** 颜色 ***/
#define DKRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define DKHexColor(hexStr) [UIColor dk_colorWithHexString:hexStr]

/*** UserDefaults ***/
#define DKSetUserDefault(key,value) [[NSUserDefaults standardUserDefaults] setObject:(value) forKey:(key)]
#define DKGetUserDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:(key)]

/*** Notification ***/
#define DKSendNotification(name,obj,userInfo) [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:name object:obj userInfo:userInfo]];

/*** 常用 ***/
#define DKScreenW [UIScreen mainScreen].bounds.size.width
#define DKScreenH [UIScreen mainScreen].bounds.size.height

#define DKLoadViewFromNib [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
#define DKLoadViewFromNibWithIndex(index) [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][index];

#define DKDeprecated(instead) __attribute__((deprecated(instead)))

#define DKNonnullString(str) ((str && [str isKindOfClass:[NSString class]] && str.length) ? str : @"")
#define DKNullableString(str) ((str && [str isKindOfClass:[NSString class]] && str.length) ? str : nil)

// 当前版本
#define DK_SYSTEM_VERSION          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DK_APP_NAME                ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define DK_APP_VERSION             ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define DK_APP_BUILD               ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

// 当前语言
#define DKCURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

// 是否高于IOS X
#define DK_isHigherIOS(version)    [[[UIDevice currentDevice]systemVersion]floatValue] > version

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
