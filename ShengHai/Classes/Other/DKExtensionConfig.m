//
//  DKExtensionConfig.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKExtensionConfig.h"

#import "DKOrder.h"
#import "DKOrderWikiFirst.h"
#import "DKOrderWikiSecond.h"
#import "DKOrderWikiThird.h"

@implementation DKExtensionConfig

+ (void)load
{
    // 统一配置id
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"Id" : @"id",
                 @"passwordNew" : @"new_password"
                 };
    }];
    
    // 订单详情
    [DKOrder mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"record" : @"DKOrderRecord"
                 };
    }];
    
    // 知识库
    [DKOrderWikiFirst mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"child" : @"DKOrderWikiSecond"
                 };
    }];
    [DKOrderWikiSecond mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"child" : @"DKOrderWikiThird"
                 };
    }];
}

@end
