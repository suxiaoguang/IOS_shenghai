//
//  DKUserChangePhoneViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewController.h"

typedef NS_ENUM(NSUInteger, DKChangeType) {
    DKChangeTypePhone,     // 修改手机号
    DKChangeTypePassword   // 修改密码
};

@interface DKUserChangePhoneViewController : DKViewController

/** 类型 */
@property (nonatomic, assign) DKChangeType changeType;

@end
