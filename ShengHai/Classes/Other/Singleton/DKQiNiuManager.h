//
//  DKQiNiuManager.h
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/11/15.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "DKQiNiuConfigInfo.h"
#import "QiniuSDK.h"

#define DKQiNiuShareManager [DKQiNiuManager sharedInstance]

@interface DKQiNiuManager : NSObject
singleton_interface(DKQiNiuManager)
/** 七牛配置信息 */
@property (nonatomic, strong) DKQiNiuConfigInfo *configInfo;

/** 获取七牛配置 */
- (void)fetchQiNiuConfigInfoWithCompletion:(void(^)())completion;

/** 上传图片到七牛 */
- (void)uploadQiNiuWithLocalImageUrl:(NSString *)urlString callback:(void (^)(NSString *, NSError *))callback;
- (void)uploadQiNiuWithImageUrl:(NSString *)urlString callback:(void(^)(NSString *key, NSError *error))callback;
- (void)uploadQiNiuWithImage:(UIImage *)image callback:(void(^)(NSString *key, NSError *error))callback;

@end
