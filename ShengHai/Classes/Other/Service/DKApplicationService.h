//
//  DKApplicationService.h
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/11/15.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKQiNiuConfigInfo.h"

@interface DKApplicationService : NSObject

/** 获取七牛配置信息 */
+ (void)fetchQiNiuConfigInfo:(void(^)(DKQiNiuConfigInfo *configInfo, NSError *error))callBack;

@end
