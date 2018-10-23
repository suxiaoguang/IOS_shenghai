//
//  DKUserService.h
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/17.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DKUserLoginRegisterParams;

@interface DKUserService : NSObject

/**
 *   用户登录
 *
 *   @param params 参数
 *   @return RACSignal
 */
+ (RACSignal *)userLoginWithParams:(DKUserLoginRegisterParams *)params;

/**
 *   发送验证码
 *
 *   @param params 参数
 *   @return RACSignal
 */
+ (RACSignal *)sendSmsWithParams:(DKUserLoginRegisterParams *)params;

/**
 *   验证短信验证码
 *
 *   @param params 参数
 *   @return RACSignal
 */
+ (RACSignal *)validateCodeWithParams:(DKUserLoginRegisterParams *)params;

/**
 *   修改密码/忘记密码设置密码
 *
 *   @param mobile 手机号码
 *   @param password 密码
 *   @param code 验证码
 *   @return RACSignal
 */
+ (RACSignal *)forgetSetPasswordWithMobile:(NSString *)mobile password:(NSString *)password code:(NSString *)code;

/**
 *   获取用户信息
 *
 *   @return RACSignal
 */
+ (RACSignal *)fetchUserInfo;


/**
 更绑手机号码

 @param phone 更绑手机号
 @param code 验证码
 @return RACSignal
 */
+ (RACSignal *)changeBindPhone:(NSString *)phone code:(NSString *)code;


/**
 检查密码

 @param password 当前密码
 @return RACSignal
 */
+ (RACSignal *)validatePassword:(NSString *)password;


/**
 修改密码

 @param old_password 旧密码
 @param passworldNew 新密码
 @return RACSignal
 */
+ (RACSignal *)changePassword:(NSString *)old_password passworldNew:(NSString *)passworldNew;

@end
