//
//  DKProfileUserInfoViewModel.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileUserInfoViewModel.h"

#import "DKProfileService.h"

@interface DKProfileUserInfoViewModel ()

@property (nonatomic, strong) NSArray <DKStaffContacts *>   *staffContacts; // 通讯录
@property (nonatomic, strong) NSArray <DKContactArea *>     *contactAreas;  // 区域列表

@property (nonatomic, strong) RACCommand    *logoutCommand;                 // 退出登录
@property (nonatomic, strong) RACCommand    *startWorkCommand;              // 上班
@property (nonatomic, strong) RACCommand    *outWorkCommand;                // 下班
@property (nonatomic, strong) RACCommand    *updateHeadImageCommand;        // 更新头像
@property (nonatomic, strong) RACCommand    *fetchStaffListCommand;         // 获取通讯录列表
@property (nonatomic, strong) RACCommand    *fetchOrderNumber;              // 获取订单统计数量
@property (nonatomic, strong) RACCommand    *fetchAccountScoreCommand;      // 获取客户评分
@property (nonatomic, strong) RACCommand    *feedbackCommand;               // 意见反馈

@property (nonatomic, strong) RACCommand    *fetchContactArea;              // 获取联系人地区
@property (nonatomic, strong) RACCommand    *fetchContactPeopleList;        // 获取小区域联系人
@property (nonatomic, strong) RACCommand    *searchContactCommand;			// 搜索联系人

@end

@implementation DKProfileUserInfoViewModel

- (NSArray<RACCommand *> *)commands
{
    return @[self.logoutCommand,
             self.startWorkCommand,
             self.outWorkCommand,
             self.updateHeadImageCommand,
             self.fetchStaffListCommand,
             self.fetchOrderNumber,
             self.fetchAccountScoreCommand,
             self.feedbackCommand,
			 self.fetchContactArea,
			 self.fetchContactPeopleList,
			 self.searchContactCommand
             ];
}

// 搜索联系人
- (RACCommand *)searchContactCommand
{
	if (!_searchContactCommand) {
		@weakify(self);
		_searchContactCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
			@strongify(self);
			if (!self.keyword.length) {
				return [RACSignal error:DKERROR(@"请输入联系人名称或工号")];
			}
			return [[DKProfileService searchContactWithKeyWord:self.keyword] map:^id(id value) {
				self.staffContacts = value;
				return value;
			}];
		}];
	}
	return _searchContactCommand;
}

// 获取联系人地区
- (RACCommand *)fetchContactArea
{
	if (!_fetchContactArea) {
		@weakify(self);
		_fetchContactArea = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
			@strongify(self);
			return [[DKProfileService fetchContactAreaList] map:^id(id value) {
				self.contactAreas = value;
				return value;
			}];
		}];
	}
	return _fetchContactArea;
}

// 获取小区域联系人
- (RACCommand *)fetchContactPeopleList
{
	if (!_fetchContactPeopleList) {
		@weakify(self);
		_fetchContactPeopleList = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
			@strongify(self);
			return [[DKProfileService fetchContactPeopleListWithMainArea:self.mainArea subArea:self.subArea] map:^id(id value) {
				self.staffContacts = value;
				return value;
			}];
		}];
	}
	return _fetchContactPeopleList;
}

// 下班
- (RACCommand *)outWorkCommand
{
    if (!_outWorkCommand) {
        _outWorkCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [DKProfileService outWork];
        }];
    }
    return _outWorkCommand;
}

// 上班
- (RACCommand *)startWorkCommand
{
    if (!_startWorkCommand) {
        _startWorkCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [DKProfileService startWork];
        }];
    }
    return _startWorkCommand;
}

// 退出登录
- (RACCommand *)logoutCommand
{
    if (!_logoutCommand) {
        _logoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [DKProfileService logout];
        }];
    }
    return _logoutCommand;
}

// 更新头像
- (RACCommand *)updateHeadImageCommand
{
    if (!_updateHeadImageCommand) {
        @weakify(self);
        _updateHeadImageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [DKProfileService updateHeadImage:self.headImageUrl];
        }];
    }
    return _updateHeadImageCommand;
}

// 获取通讯录列表
- (RACCommand *)fetchStaffListCommand
{
    if (!_fetchStaffListCommand) {
        @weakify(self);
        _fetchStaffListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[DKProfileService fetchStaffList] map:^id(id value) {
                self.staffContacts = value;
                return value;
            }];
        }];
    }
    return _fetchStaffListCommand;
}

// 获取订单统计数量
- (RACCommand *)fetchOrderNumber
{
    if (!_fetchOrderNumber) {
        @weakify(self);
        _fetchOrderNumber = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[DKProfileService fetchOrderNumber] map:^id(id value) {
                self.orderNumber = value;
                return value;
            }];
        }];
    }
    return _fetchOrderNumber;
}

// 获取用户评分
- (RACCommand *)fetchAccountScoreCommand
{
    if (!_fetchAccountScoreCommand) {
        _fetchAccountScoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[DKProfileService fetchAccountScore] map:^id(id value) {
                self.starInfo = value;
                return value;
            }];
        }];
    }
    return _fetchAccountScoreCommand;
}

// 意见反馈
- (RACCommand *)feedbackCommand
{
    if (!_feedbackCommand) {
        _feedbackCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [DKProfileService writeFeedbackWithContent:input];
        }];
    }
    return _feedbackCommand;
}

@end
