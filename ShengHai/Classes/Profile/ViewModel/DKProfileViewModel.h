//
//  DKProfileViewModel.h
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/15.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKViewModel.h"

@interface DKProfileViewModel : DKViewModel

/** 控制器 */
@property (nonatomic, strong, readonly) NSArray *viewControllers;
/** cell标题 */
@property (nonatomic, strong, readonly) NSArray *titles;
/** cell图标 */
@property (nonatomic, strong, readonly) NSArray *cellIcons;

@end
