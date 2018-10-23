//
//  DKUserLoginRegisterViewModel.m
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/18.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKUserLoginRegisterViewModel.h"

#import "DKUserService.h"

#import "DKUserLoginRegisterParams.h"

@interface DKUserLoginRegisterViewModel ()
@property (nonatomic, strong) RACCommand    *loginCommand;              // 登录命令
@property (nonatomic, strong) RACCommand    *sendSmsCommand;            // 发送验证码命令
@property (nonatomic, strong) RACCommand    *validateCodeCommand;       // 验证验证码命令
@property (nonatomic, strong) RACCommand    *userForgetCommand;         // 用户忘记密码命令
@property (nonatomic, strong) RACCommand    *validatePhoneCommand;      // 校验手机号码
@property (nonatomic, strong) RACCommand    *changePhoneCommand;        // 更绑手机号码
@property (nonatomic, strong) RACCommand    *validatePassworldCommand;  // 校验当前密码
@property (nonatomic, strong) RACCommand    *changePassworldCommand;    // 修改密码
@end

@implementation DKUserLoginRegisterViewModel
#pragma mark - setters && getters
- (NSArray <RACCommand *> *)commands
{
    return @[self.loginCommand,
             self.sendSmsCommand,
             self.validateCodeCommand,
             self.userForgetCommand,
             self.validatePhoneCommand,
             self.changePhoneCommand,
             self.validatePassworldCommand,
             self.changePassworldCommand
             ];
}

- (DKUserLoginRegisterParams *)userLoginRegisterParams
{
    if (!_userLoginRegisterParams) {
        _userLoginRegisterParams = [[DKUserLoginRegisterParams alloc] init];
    }

    return _userLoginRegisterParams;
}

// 校验当前密码
- (RACCommand *)validatePassworldCommand
{
    if (!_validatePassworldCommand) {
        @weakify(self);
        _validatePassworldCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self validationOldPassworldParams:self.userLoginRegisterParams] ? :
            [DKUserService validatePassword:self.userLoginRegisterParams.old_password];
        }];
    }
    return _validatePassworldCommand;
}

// 修改密码
- (RACCommand *)changePassworldCommand
{
    if (!_changePassworldCommand) {
        @weakify(self);
        _changePassworldCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self validationForgetPasswordParams:self.userLoginRegisterParams] ? :
            [DKUserService changePassword:self.userLoginRegisterParams.old_password passworldNew:self.userLoginRegisterParams.passwordNew];
        }];
    }
    return _changePassworldCommand;
}

// 更绑手机号码
- (RACCommand *)changePhoneCommand
{
    if (!_changePhoneCommand) {
        @weakify(self);
        _changePhoneCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self validationCodeParams:self.userLoginRegisterParams] ? :
            [DKUserService changeBindPhone:self.userLoginRegisterParams.staff_phone code:self.userLoginRegisterParams.code];
        }];
    }
    return _changePhoneCommand;
}

// 校验手机号命令
- (RACCommand *)validatePhoneCommand
{
    if (!_validatePhoneCommand) {
        @weakify(self);
        _validatePhoneCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            if ([self.userLoginRegisterParams.old_phone isEqualToString:DKUserInfoCache.staff_phone]) {
                return [RACSignal return:@YES];
            } else if (!self.userLoginRegisterParams.old_phone.length) {
                return [RACSignal error:DKERROR(@"请输入现手机号码")];
            } else {
                return [RACSignal error:DKERROR(@"输入手机号与现手机号不符")];
            }
        }];
    }
    return _validatePhoneCommand;
}

// 用户登录命令
- (RACCommand *)loginCommand
{
    if (!_loginCommand) {
        @weakify(self);
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self validationLoginParams:self.userLoginRegisterParams] ? :
            [[DKUserService userLoginWithParams:self.userLoginRegisterParams] map:^id (NSString *token) {
                [DKNetworking setNetworkHeader:@{@"token" : DKNonnullString(token)}];
                DKSetUserDefault(@"token", token);
                return nil;
            }];
        }];
    }
    
    return _loginCommand;
}

// 用户发送验证码短信命令
- (RACCommand *)sendSmsCommand
{
    if (!_sendSmsCommand) {
        @weakify(self);
        _sendSmsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                return [self validationSendSmsParams:self.userLoginRegisterParams] ? :
                [DKUserService sendSmsWithParams:self.userLoginRegisterParams];
            }];
    }

    return _sendSmsCommand;
}

// 用户验证验证码命令
- (RACCommand *)validateCodeCommand
{
    if (!_validateCodeCommand) {
        @weakify(self);
        _validateCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                return [self validationCodeParams:self.userLoginRegisterParams] ? :
                [DKUserService validateCodeWithParams:self.userLoginRegisterParams];
            }];
    }

    return _validateCodeCommand;
}

// 忘记密码输入密码命令
- (RACCommand *)userForgetCommand
{
    if (!_userForgetCommand) {
        @weakify(self);
        _userForgetCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                return [self validationForgetPasswordParams:self.userLoginRegisterParams] ? :
                [DKUserService forgetSetPasswordWithMobile:self.userLoginRegisterParams.staff_phone
                password:self.userLoginRegisterParams.passwordNew
                code    :self.userLoginRegisterParams.code];
            }];
    }

    return _userForgetCommand;
}

#pragma mark - Private
// 验证获取验证码参数
- (RACSignal *)validationSendSmsParams:(DKUserLoginRegisterParams *)params
{
    if (!params.staff_phone.length) {
        return [RACSignal error:DKERROR(@"请输入手机号码")];
    } else if (![params.staff_phone dk_isPhoneNum]) {
        return [RACSignal error:DKERROR(@"请输入正确的手机号码")];
    }
    return nil;
}

// 验证验证码参数
- (RACSignal *)validationCodeParams:(DKUserLoginRegisterParams *)params
{
    if (![params.staff_phone dk_isPhoneNum]) {
        return [RACSignal error:DKERROR(@"请输入正确的手机号码")];
    } else if (params.code.length != 4) {
        return [RACSignal error:DKERROR(@"请输入4位验证码")];
    }

    return nil;
}

// 验证设置密码参数
- (RACSignal *)validationSetPasswordParams:(DKUserLoginRegisterParams *)params
{
    if (!params.password.length) {
        return [RACSignal error:DKERROR(@"请输入密码")];
    } else if (!(params.password.length >= 6) || !(params.password.length <= 20)) {
        return [RACSignal error:DKERROR(@"请输入6-20位密码")];
    } else if ([params.password dk_isHaveIllegalChar]) {
        return [RACSignal error:DKERROR(@"请输入数字和字母密码组合")];
    }

    return nil;
}

// 验证忘记密码参数
- (RACSignal *)validationForgetPasswordParams:(DKUserLoginRegisterParams *)params
{
    if (!params.wait_password.length) {
        return [RACSignal error:DKERROR(@"请输入密码")];
    } else if (!(params.wait_password.length >= 6) || !(params.password.length <= 20)) {
        return [RACSignal error:DKERROR(@"请输入6-20位密码")];
    } else if ([params.wait_password dk_isHaveIllegalChar]) {
        return [RACSignal error:DKERROR(@"请输入数字和字母密码组合")];
    } else if (!params.passwordNew.length) {
        return [RACSignal error:DKERROR(@"请再次输入密码")];
    } else if (![params.wait_password isEqualToString:params.passwordNew]) {
        return [RACSignal error:DKERROR(@"两次输入密码不一致")];
    }

    return nil;
}

// 验证登录参数
- (RACSignal *)validationLoginParams:(DKUserLoginRegisterParams *)params
{
    if (!params.staff_code.length) {
        return [RACSignal error:DKERROR(@"请输入账号")];
    } else if (!params.password.length) {
        return [RACSignal error:DKERROR(@"请输入6-20位密码")];
    }

    return nil;
}

// 验证旧密码
- (RACSignal *)validationOldPassworldParams:(DKUserLoginRegisterParams *)params
{
    if (!params.old_password.length) {
        return [RACSignal error:DKERROR(@"请输入6-20位密码")];
    }
    
    return nil;
}

@end
