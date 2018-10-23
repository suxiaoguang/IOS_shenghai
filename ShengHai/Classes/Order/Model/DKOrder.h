//
//  DKOrder.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DKOrderRecord.h"

@interface DKOrder : NSObject

/** 订单id */
@property (nonatomic, copy) NSString *order_id;
/** 客户姓名 */
@property (nonatomic, copy) NSString *contact_name;
/** 客户电话 */
@property (nonatomic, copy) NSString *contact_phone;
/** 客户地址 */
@property (nonatomic, copy) NSString *contact_address;
/** 故障描述 文本 */
@property (nonatomic, copy) NSString *describe_text;
/** 故障描述 图片url 逗号「,」作为分隔符 */
@property (nonatomic, copy) NSString *describe_images;
/** 故障描述 音频文件 url */
@property (nonatomic, copy) NSString *describe_voice;
/** 语音时间长度 */
@property (nonatomic, copy) NSString *describe_voice_duration;
/** 员工姓名 -- 你的姓名 */
@property (nonatomic, copy) NSString *staff_name;
/** 员工电话 */
@property (nonatomic, copy) NSString *staff_phone;
/** 预约时间戳 */
@property (nonatomic, copy) NSString *appoint_time;
/** 维修记录数组 */
@property (nonatomic, strong) NSArray<DKOrderRecord *> *record;
/** 订单下单时间 */
@property (nonatomic, copy) NSString *order_create_time;
/** 状态文本 */
@property (nonatomic, copy) NSString *status_text;
/** 状态所处哪个tab */
@property (nonatomic, copy) NSString *status_tab;
/** 工程师是否已确认 */
@property (nonatomic, copy) NSString *is_staff_complete;
/** 订单是否被取消 */
@property (nonatomic, copy) NSString *is_close;

// ext
/** 故障描述图片1 */
@property (nonatomic, copy) NSString *image1;
/** 故障描述图片2 */
@property (nonatomic, copy) NSString *image2;
/** 故障描述图片3 */
@property (nonatomic, copy) NSString *image3;

/** 工号(新加) */
@property (nonatomic, copy) NSString *staff_json_code;

@end
