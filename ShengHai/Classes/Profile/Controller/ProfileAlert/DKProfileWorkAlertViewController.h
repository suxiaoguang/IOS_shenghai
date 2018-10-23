//
//  DKProfileWorkAlertViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewController.h"

typedef void(^DKWordBlock)(BOOL isWork);

@interface DKProfileWorkAlertViewController : DKViewController

/** 是否工作回调 */
@property (nonatomic, strong) DKWordBlock workBlock;
/** 上班/下班 */
@property (nonatomic, copy) NSString *type;

@end
