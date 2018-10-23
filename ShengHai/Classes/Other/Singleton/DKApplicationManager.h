//
//  DKApplicationManager.h
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/11/21.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface DKApplicationManager : NSObject
singleton_interface(DKApplicationManager)

/** 设置程序主窗口 */
- (void)setupWindow:(UIWindow *)window application:(UIApplication *)application options:(NSDictionary *)launchOptions;


@end
