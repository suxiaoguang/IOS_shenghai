//
//  DKUserService.m
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/17.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKUserService.h"

#import "DKUserInfo.h"
#import "DKUserLoginRegisterParams.h"

@implementation DKUserService

// 用户登录
+ (RACSignal *)userLoginWithParams:(DKUserLoginRegisterParams *)params
{
    return [DKNetworkManager.post(@"Index/login")
            .params(params.mj_keyValues)
            .executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
               DKHttpResponse *response = tuple.second;

               if (response.error) {
                   return [RACSignal error:response.error];
               } else {
                   DKUserInfo *userInfo = [DKUserInfo mj_objectWithKeyValues:response.data[@"staff"]];
                   [userInfo cacheUserInfo:userInfo];
                   return [RACSignal return :response.data[@"token"][@"token"]];
               }
           }];
}

// 发送验证码
+ (RACSignal *)sendSmsWithParams:(DKUserLoginRegisterParams *)params
{
    return [DKNetworkManager.post(@"Index/sendSms")
               .params(params.mj_keyValues)
               .executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
               DKHttpResponse *response = tuple.second;

               if (response.error) {
                   return [RACSignal error:response.error];
               } else {
                   return [RACSignal return :@YES];
               }
           }];
}

// 验证验证码
+ (RACSignal *)validateCodeWithParams:(DKUserLoginRegisterParams *)params
{
    return [DKNetworkManager.post(@"Index/validateCode")
               .params(params.mj_keyValues)
               .executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
               DKHttpResponse *response = tuple.second;

               if (response.error) {
                   return [RACSignal error:response.error];
               } else {
                   return [RACSignal return :@YES];
               }
           }];
}

// 修改密码/忘记密码设置密码
+ (RACSignal *)forgetSetPasswordWithMobile:(NSString *)mobile password:(NSString *)password code:(NSString *)code
{
    NSDictionary *params = @{@"staff_phone":DKNonnullString(mobile),
                             @"password":DKNonnullString(password),
                             @"code":DKNonnullString(code)};

    return [DKNetworkManager.post(@"Index/setPassword")
               .params(params)
               .executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
               DKHttpResponse *response = tuple.second;

               if (response.error) {
                   return [RACSignal error:response.error];
               } else {
                   return [RACSignal return :@YES];
               }
           }];
}

// 获取用户信息
+ (RACSignal *)fetchUserInfo
{
    return [DKNetworkManager.post(@"Mine/info")
               .executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
               DKHttpResponse *response = tuple.second;

               if (response.error) {
                   return [RACSignal error:response.error];
               } else {
                   DKUserInfo *userInfo = [DKUserInfo mj_objectWithKeyValues:response.data[@"user_info"]];
                   return [RACSignal return :userInfo];
               }
           }];
}

// 更绑手机号码
+ (RACSignal *)changeBindPhone:(NSString *)phone code:(NSString *)code
{
    NSDictionary *params = @{@"staff_phone":DKNonnullString(phone),
                             @"code":DKNonnullString(code)};
    
    return [DKNetworkManager.post(@"Staff/bindPhone")
            .params(params)
            .executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
                DKHttpResponse *response = tuple.second;
                
                if (response.error) {
                    return [RACSignal error:response.error];
                } else {
                    return [RACSignal return :@YES];
                }
            }];
}

// 检查密码
+ (RACSignal *)validatePassword:(NSString *)password
{
    NSDictionary *params = @{@"password":DKNonnullString(password)
                             };
    
    return [DKNetworkManager.post(@"Staff/checkPassword")
            .params(params)
            .executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
                DKHttpResponse *response = tuple.second;
                
                if (response.error) {
                    return [RACSignal error:response.error];
                } else {
                    return [RACSignal return :@YES];
                }
            }];
}

// 修改密码
+ (RACSignal *)changePassword:(NSString *)old_password passworldNew:(NSString *)passworldNew
{
    NSDictionary *params = @{@"old_password":DKNonnullString(old_password),
                             @"new_password":DKNonnullString(passworldNew)
                             };
    
    return [DKNetworkManager.post(@"Staff/updatePassword")
            .params(params)
            .executeSignal flattenMap:^RACStream *(RACTuple *tuple) {
                DKHttpResponse *response = tuple.second;
                
                if (response.error) {
                    return [RACSignal error:response.error];
                } else {
                    return [RACSignal return :@YES];
                }
            }];
}

@end
