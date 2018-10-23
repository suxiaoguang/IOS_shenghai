//
//  DKOrderStaff.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/5.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKOrderStaff : NSObject

/** 员工id */
@property (nonatomic, copy) NSString *staff_id;
/** 姓名 */
@property (nonatomic, copy) NSString *staff_name;
/** 头像url */
@property (nonatomic, copy) NSString *headimgurl;
/** 是否在上班，0或1 */
@property (nonatomic, copy) NSString *is_working;

@end
