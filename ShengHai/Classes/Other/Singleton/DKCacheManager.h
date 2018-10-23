//
//  DKCacheManager.h
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/11/14.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCache.h"

@interface DKCacheManager : YYCache
+ (instancetype)sharedInstance;
@end
