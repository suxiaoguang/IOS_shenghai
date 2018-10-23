//
//  DKCacheManager.m
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/11/14.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKCacheManager.h"

#define DKCacheKey @"DKCache"

@interface DKCacheManager ()
@property (nonatomic, strong) YYCache *cache;
@end

@implementation DKCacheManager

static DKCacheManager *_instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

+ (instancetype)sharedInstance
{
    if (_instance == nil) {
        _instance = [[DKCacheManager alloc] initWithName:DKCacheKey];
    }
    
    return _instance;
}

@end
