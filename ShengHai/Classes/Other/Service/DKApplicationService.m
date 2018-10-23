//
//  DKApplicationService.m
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/11/15.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKApplicationService.h"
#import "DKQiNiuManager.h"

@implementation DKApplicationService

+ (void)fetchQiNiuConfigInfo:(void (^)(DKQiNiuConfigInfo *, NSError *))callBack
{
    NSString *urlStr = [NSString stringWithFormat:@"%@index.php/app/Index/qiniu",DKAPIDomain];
    
    [DKNetworkManager POST:urlStr parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        DKQiNiuConfigInfo *configInfo = [DKQiNiuConfigInfo mj_objectWithKeyValues:response.rawData[@"data"]];
        callBack(configInfo, response.error);
    }];
}

@end
