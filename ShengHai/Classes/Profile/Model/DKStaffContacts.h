//
//  DKStaffContacts.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKStaffContacts : NSObject

/** 工程师id */
@property (nonatomic, copy) NSString *staff_id;
/** 工程师工号 */
@property (nonatomic, copy) NSString *staff_code;
/** 姓名 */
@property (nonatomic, copy) NSString *staff_name;
/** 手机 */
@property (nonatomic, copy) NSString *staff_phone;
/** 头像地址 */
@property (nonatomic, copy) NSString *headimgurl;
/** 工程师邮箱 */
@property (nonatomic, copy) NSString *staff_email;

@end
