//
//  DKUserLoginRegisterParams.h
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/18.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKUserLoginRegisterParams : NSObject

// 登录
/** 工号 */
@property (nonatomic, copy) NSString *staff_code;
/** 更绑手机号 */
@property (nonatomic, copy) NSString *old_phone;
/** 账号/手机号 */
@property (nonatomic, copy) NSString *staff_phone;
/** 密码 */
@property (nonatomic, copy) NSString *password;

// 忘记密码
/** 发送验证码类型 事件类型：'bind', 'forgot' */
@property (nonatomic, copy) NSString *sms_type;
/** 短信验证码 */
@property (nonatomic, copy) NSString *code;

// 修改密码
/** 旧密码 */
@property (nonatomic, copy) NSString *old_password;
/** 待确认密码 */
@property (nonatomic, copy) NSString *wait_password;
/** 新密码 */
@property (nonatomic, copy) NSString *passwordNew;

@end
