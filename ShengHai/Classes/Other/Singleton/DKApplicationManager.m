//
//  DKApplicationManager.m
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/11/21.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKApplicationManager.h"

#import "DKTabBarController.h"
#import "DKNavigationController.h"
#import "DKUserLoginViewController.h"

#import "DKQiNiuManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "DKUncaughtExceptionHandler.h"

@interface DKApplicationManager ()
@property (nonatomic, copy) NSString *serverTime;
@property (nonatomic, strong) NSTimer *serverTimer;
@property (nonatomic, strong) NSArray *refreshImages;
@property (nonatomic, strong) NSArray *normalImages;

@end

@implementation DKApplicationManager
singleton_implementation(DKApplicationManager)

#pragma mark - Getter && Setter

#pragma mark - Life Cycle


#pragma mark - Public

- (void)setupWindow:(UIWindow *)window application:(UIApplication *)application options:(NSDictionary *)launchOptions
{
    window.backgroundColor = [UIColor whiteColor];

    if (DKToken) {
        window.rootViewController = [[DKTabBarController alloc] init];
    } else {
        window.rootViewController = [[DKNavigationController alloc] initWithRootViewController:[[DKUserLoginViewController alloc] init]];
    }
    
    [[[DKUncaughtExceptionHandler alloc] init] installExceptionHandler];
    [window makeKeyAndVisible];
    
    // 第三方框架配置
    [self setupThirdPartyWithApplication:application options:launchOptions];
}


#pragma mark - Pirvate

// 第三方配置
- (void)setupThirdPartyWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions
{
    [self setupIQKeyboard];
    [self setupQiNiu];
}

// 键盘处理
- (void)setupIQKeyboard
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.toolbarManageBehaviour = IQAutoToolbarByTag;
}

// 获取七牛配置
- (void)setupQiNiu
{
    [DKQiNiuShareManager fetchQiNiuConfigInfoWithCompletion:nil];
}

@end
