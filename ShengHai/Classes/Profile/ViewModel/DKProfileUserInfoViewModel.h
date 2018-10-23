//
//  DKProfileUserInfoViewModel.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileViewModel.h"

#import "DKStaffContacts.h"
#import "DKOrderNumber.h"
#import "DKProfileStarInfo.h"
#import "DKContactArea.h"

@interface DKProfileUserInfoViewModel : DKProfileViewModel

/** 头像地址 */
@property (nonatomic, copy) NSString *headImageUrl;

/** 通讯录 */
@property (nonatomic, strong, readonly) NSArray<DKStaffContacts *> *staffContacts;
/** 区域列表 */
@property (nonatomic, strong, readonly) NSArray<DKContactArea *> *contactAreas;
/** 订单数统计 */
@property (nonatomic, strong) DKOrderNumber *orderNumber;
/** 评分 */
@property (nonatomic, strong) DKProfileStarInfo *starInfo;

/** 搜索联系人关键字 */
@property (nonatomic, copy) NSString *keyword;
/** 大区 */
@property (nonatomic, copy) NSString *mainArea;
/** 小区 */
@property (nonatomic, copy) NSString *subArea;

/** 退出登录 */
@property (nonatomic, strong, readonly) RACCommand *logoutCommand;
/** 上班 */
@property (nonatomic, strong, readonly) RACCommand *startWorkCommand;
/** 下班 */
@property (nonatomic, strong, readonly) RACCommand *outWorkCommand;
/** 更新头像 */
@property (nonatomic, strong, readonly) RACCommand *updateHeadImageCommand;
/** 通讯录列表 */
@property (nonatomic, strong, readonly) RACCommand *fetchStaffListCommand;
/** 获取订单统计数量 */
@property (nonatomic, strong, readonly) RACCommand *fetchOrderNumber;
/** 获取客户评分 */
@property (nonatomic, strong, readonly) RACCommand *fetchAccountScoreCommand;
/** 意见反馈 */
@property (nonatomic, strong, readonly) RACCommand *feedbackCommand;

/** 获取联系人地区 */
@property (nonatomic, strong, readonly) RACCommand *fetchContactArea;
/** 获取小区域联系人 */
@property (nonatomic, strong, readonly) RACCommand *fetchContactPeopleList;
/** 搜索联系人 */
@property (nonatomic, strong, readonly) RACCommand *searchContactCommand;

@end
