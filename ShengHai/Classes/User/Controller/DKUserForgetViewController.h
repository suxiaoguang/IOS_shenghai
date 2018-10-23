//
//  DKUserForgetViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/20.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewController.h"

typedef NS_ENUM(NSUInteger, DKResetAccountType) {
    DKResetAccountTypeForgetPassword,   // 忘记密码
    DKResetAccountTypeChangePhone       // 修改手机号
};

@interface DKUserForgetViewController : DKViewController

/** 类型 */
@property (nonatomic, assign) DKResetAccountType resetAccountType;

/** type */
@property (nonatomic, copy) NSString *type;

@end
