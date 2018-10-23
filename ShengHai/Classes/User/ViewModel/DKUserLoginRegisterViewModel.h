//
//  DKUserLoginRegisterViewModel.h
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/18.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewModel.h"

@class DKUserLoginRegisterParams;

@interface DKUserLoginRegisterViewModel : DKViewModel

/** 用户登录注册参数 */
@property (nonatomic, strong) DKUserLoginRegisterParams *userLoginRegisterParams;

/** 登录命令 */
@property (nonatomic, strong, readonly) RACCommand *loginCommand;
/** 用户发送验证码短信命令 */
@property (nonatomic, strong, readonly) RACCommand *sendSmsCommand;
/** 用户验证验证码命令 */
@property (nonatomic, strong, readonly) RACCommand *validateCodeCommand;
/** 忘记密码命令 */
@property (nonatomic, strong, readonly) RACCommand *userForgetCommand;
/** 校验手机号码 */
@property (nonatomic, strong, readonly) RACCommand *validatePhoneCommand;
/** 更绑手机号码 */
@property (nonatomic, strong, readonly) RACCommand *changePhoneCommand;
/** 校验当前密码 */
@property (nonatomic, strong, readonly) RACCommand *validatePassworldCommand;
/** 修改密码 */
@property (nonatomic, strong, readonly) RACCommand *changePassworldCommand;

@end
