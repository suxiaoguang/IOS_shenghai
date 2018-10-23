//
//  DKProfileHelpViewModel.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/21.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileHelpViewModel.h"

#import "DKProfileService.h"

@interface DKProfileHelpViewModel ()
@property (nonatomic, strong) NSArray   *viewControllers;
@property (nonatomic, strong) NSArray   *titles;

@property (nonatomic, strong) RACCommand *fetchQuestionsCommand; // 获取常见问题
@property (nonatomic, strong) RACCommand *fetchRulesCommand; // 获取平台规则
@property (nonatomic, strong) RACCommand *fetchContactInformationCommand; // 获取联系方式
@end

@implementation DKProfileHelpViewModel

- (NSArray<RACCommand *> *)commands
{
    return @[self.fetchQuestionsCommand,
             self.fetchRulesCommand,
             self.fetchContactInformationCommand
             ];
}

// 获取常见问题
- (RACCommand *)fetchQuestionsCommand
{
    if (!_fetchQuestionsCommand) {
        _fetchQuestionsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [DKProfileService fetchQuestions];
        }];
    }
    return _fetchQuestionsCommand;
}

// 获取平台规则
- (RACCommand *)fetchRulesCommand
{
    if (!_fetchRulesCommand) {
        _fetchRulesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [DKProfileService fetchRules];
        }];
    }
    return _fetchRulesCommand;
}

// 获取联系方式
- (RACCommand *)fetchContactInformationCommand
{
    if (!_fetchContactInformationCommand) {
        _fetchContactInformationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[DKProfileService fetchContactInformation] map:^id(id value) {
                self.contactInformation = value;
                return value;
            }];
        }];
    }
    return _fetchContactInformationCommand;
}

- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = @[@"DKHelpProblemViewController",
                             @"DKProfileHelpRulesViewController",
                             @"DKSettingAboutViewController",
                             @"",
                             @"DKUserChangePhoneViewController",
                             @"DKUserChangePhoneViewController"
                             ];
    }
    
    return _viewControllers;
}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"常见问题",
                    @"平台规则",
                    @"关于我们",
                    @"联系客服",
                    @"修改密码",
                    @"更绑手机号"
                    ];
    }
    
    return _titles;
}

@end
