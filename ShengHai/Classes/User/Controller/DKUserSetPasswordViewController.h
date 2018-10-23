//
//  DKUserSetPasswordViewController.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/21.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewController.h"

#import "DKUserLoginRegisterViewModel.h"

typedef NS_ENUM(NSUInteger, DKSetPasswordType) {
    DKSetPasswordTypeForgetPassword,   // 忘记密码
    DKSetPasswordTypeChangePassword    // 修改密码
};

@interface DKUserSetPasswordViewController : DKViewController

/** 类型 */
@property (nonatomic, assign) DKSetPasswordType resetAccountType;

@property (nonatomic, strong) DKUserLoginRegisterViewModel *vm;       // vm

@end
