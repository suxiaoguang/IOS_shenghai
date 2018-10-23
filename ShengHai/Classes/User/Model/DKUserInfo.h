//
//  DKUserInfo.h
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/18.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKUserInfo : NSObject<NSCoding>

/** 工程师id */
@property (nonatomic, copy) NSString *staff_id;
/** 手机号 */
@property (nonatomic, copy) NSString *staff_phone;
/** 工号 */
@property (nonatomic, copy) NSString *staff_code;
/** 姓名 */
@property (nonatomic, copy) NSString *staff_name;
/** 部门 */
@property (nonatomic, copy) NSString *region_main;
/** 地区 */
@property (nonatomic, copy) NSString *region_sub;
/** 职位 */
@property (nonatomic, copy) NSString *staff_class;
/** 工程师等级 */
@property (nonatomic, copy) NSString *staff_level;
/** 工作地区 */
@property (nonatomic, copy) NSString *work_area;
/** 邮箱 */
@property (nonatomic, copy) NSString *staff_email;
/** 头像 */
@property (nonatomic, copy) NSString *headimgurl;

- (void)cacheUserInfo:(DKUserInfo *)userInfo;

@end
