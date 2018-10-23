//
//  DKProfileHelpViewModel.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/21.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewModel.h"

#import "DKContactInformation.h"

@interface DKProfileHelpViewModel : DKViewModel
/** 控制器 */
@property (nonatomic, strong, readonly) NSArray *viewControllers;
/** cell标题 */
@property (nonatomic, strong, readonly) NSArray *titles;

@property (nonatomic, strong) DKContactInformation *contactInformation;

/** 获取常见问题 */
@property (nonatomic, strong, readonly) RACCommand *fetchQuestionsCommand;
/** 获取平台规则 */
@property (nonatomic, strong, readonly) RACCommand *fetchRulesCommand;
/** 获取联系方式 */
@property (nonatomic, strong, readonly) RACCommand *fetchContactInformationCommand;

@end
