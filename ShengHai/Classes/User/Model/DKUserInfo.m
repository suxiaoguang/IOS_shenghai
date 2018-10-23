//
//  DKUserInfo.m
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/18.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKUserInfo.h"

@implementation DKUserInfo
MJCodingImplementation

- (void)cacheUserInfo:(DKUserInfo *)userInfo
{
    DKSetCache(@"userInfo", userInfo);
}

@end
