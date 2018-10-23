//
//  DKQiNiuManager.m
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/11/15.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKQiNiuManager.h"
#import "DKApplicationService.h"

@interface DKQiNiuManager ()
@property (nonatomic, strong) QNUploadManager *uploadManager;
@end

@implementation DKQiNiuManager
singleton_implementation(DKQiNiuManager)

- (QNUploadManager *)uploadManager
{
    if (!_uploadManager) {
        _uploadManager = [[QNUploadManager alloc] init];
    }
    return _uploadManager;
}

#pragma mark - Public

- (void)fetchQiNiuConfigInfoWithCompletion:(void (^)())completion
{
    // 获取七牛配置
    [DKApplicationService fetchQiNiuConfigInfo:^(DKQiNiuConfigInfo *configInfo, NSError *error) {
        if (!error) {
            _configInfo = configInfo;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:DKUserInfoDidUpdatedNotification object:nil];
            
            if (completion)
                completion();
            
            DKLog(@"Fetch QiNiu Success. uptoken:%@", configInfo.uptoken);
        } else {
            DKLog(@"Fetch QiNiu Error.");
        }
    }];
}

- (void)uploadQiNiuWithLocalImageUrl:(NSString *)urlString callback:(void (^)(NSString *, NSError *))callback
{
    NSData *data = [NSData dataWithContentsOfFile:urlString];
    [self uploadQiNiuWithData:data callback:callback];
}

- (void)uploadQiNiuWithImageUrl:(NSString *)urlString callback:(void (^)(NSString *, NSError *))callback
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    [self uploadQiNiuWithData:data callback:callback];
}

- (void)uploadQiNiuWithImage:(UIImage *)image callback:(void (^)(NSString *, NSError *))callback
{
    // 摄像头拍的照片原图基本都有5~6M，从相册里选的截图等一般是2M以下，这是一个粗略的计算压缩系数的公式
    CGFloat scale = 0.7f - ([UIImageJPEGRepresentation(image, 1) length] / 1000 - 2000) / 500 * 0.05f;
    if (scale <= 0) scale = 0.1;
    else if (scale > 1) scale = 1;
    
    NSData *data = UIImageJPEGRepresentation(image, scale);
    [self uploadQiNiuWithData:data callback:callback];
}

#pragma mark - Private

- (void)uploadQiNiuWithData:(NSData *)data callback:(void (^)(NSString *, NSError *))callback
{
    NSInteger random = arc4random_uniform(CGFLOAT_MAX);
    NSString *key = [NSString stringWithFormat:@"sh%@%f%ld.jpeg",DKToken,[[NSDate date] timeIntervalSince1970],(long)random];
    
    if (!self.configInfo.uptoken.length) {
        [self fetchQiNiuConfigInfoWithCompletion:^{
            [self uploadQiNiuWithData:data callback:callback];
        }];
    } else {
        [self.uploadManager putData:data key:key token:self.configInfo.uptoken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            if (callback) {
                if (info.statusCode == 200) {
                    callback(key, nil);
                } else {
                    callback(nil, [NSError errorWithDomain:DKAPIDomain code:0 userInfo:@{@"message":@"七牛上传图片失败"}]);
                }
            }
        } option:nil];
    }
}

@end
