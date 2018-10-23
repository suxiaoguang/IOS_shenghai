//
//  DKProfileViewModel.m
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/15.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileViewModel.h"

@interface DKProfileViewModel ()
@property (nonatomic, strong) NSArray   *viewControllers;
@property (nonatomic, strong) NSArray   *titles;
@property (nonatomic, strong) NSArray   *cellIcons;
@end

@implementation DKProfileViewModel

- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = @[@"DKProfileNotificationViewController",
                             @"DKProfileKnowledgeViewController",
                             @"DKProfileAddressBookViewController",
                             @"DKProfileFeedbackViewController",
                             @"DKProfileHelpViewController"
        ];
    }

    return _viewControllers;
}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"消息通知",
                    @"知识库",
                    @"通讯录",
                    @"意见反馈",
                    @"帮助"
        ];
    }

    return _titles;
}

- (NSArray *)cellIcons
{
    if (!_cellIcons) {
        _cellIcons = @[@"ic_my_news",
                       @"ic_my_knowledge",
                       @"ic_my_contact_list",
                       @"ic_my_feedback",
                       @"ic_my_help"
        ];
    }

    return _cellIcons;
}

@end
