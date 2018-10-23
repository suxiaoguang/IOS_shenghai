//
//  DKHTTPTool.m
//  TYGoods
//
//  Created by 庄槟豪 on 2017/3/20.
//  Copyright © 2017年 TY. All rights reserved.
//

#import "DKHTTPTool.h"

#define DKAPI_SUCCESS_CODE @"200"

@implementation DKHTTPTool

+ (void)load
{
    [super load];
    
    // 开启日志打印
    [DKNetworking openLog];
    
    // 设置缓存方式
//    [DKNetworking setupCacheType:DKNetworkCacheTypeCacheNetwork];
    
    // 设置接口请求序列化格式
    [DKNetworking setRequestSerializer:DKRequestSerializerJSON];
    
    // API 根路径
    [DKNetworking setupBaseURL:DKAPIBaseURL];
    
    if (DKToken) {
        [DKNetworking setNetworkHeader:@{@"token" : DKToken}];
    }
    
    // 设置回调的信号的return值
    [DKNetworking setupResponseSignalWithFlattenMapBlock:^RACStream *(RACTuple *tuple) {
        DKNetworkResponse *response = tuple.second;
        DKHttpResponse *myResponse = [DKHttpResponse mj_objectWithKeyValues:response.rawData];
        myResponse.rawData = response.rawData;
        myResponse.error = response.error;
        myResponse.data = response.rawData[@"data"];
        
        // 数据层的error
        if (!myResponse.error && ![myResponse.code isEqualToString:DKAPI_SUCCESS_CODE]) {
            myResponse.error = DKERROR(myResponse.message);
            // 异常情况需要处理的通知
            if ([myResponse.code isEqualToString:@"401"]) { // 未登录 (会话已过期，请重新登录)
                [UIApplication sharedApplication].keyWindow.rootViewController = [[DKNavigationController alloc] initWithRootViewController:[[DKUserLoginViewController alloc] init]];
                [DKProgressHUD showErrorWithStatus:@"登录失效,请重新登录"];
            }
        }
        return [RACSignal return:RACTuplePack(tuple.first, myResponse)];
    }];
}

@end
