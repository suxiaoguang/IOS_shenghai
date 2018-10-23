//
//  ALAssetsLibrary category to handle a custom photo album
//  DKExtension
//  Created by Marin Todorov on 10/26/11.
//  Edited by Arclin on 16/12/30.
//  Copyright (c) 2011 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface ALAssetsLibrary (DKExtension)


/**
 把图片写入指定相册

 @param image 图片
 @param albumName 相册名(Camera Roll 系列相册)
 @param completion 完成回调
 @param failure 失败回调
 */
- (void)dk_saveImage:(UIImage *)image
          toAlbum:(NSString *)albumName
       completion:(ALAssetsLibraryWriteImageCompletionBlock)completion
          failure:(ALAssetsLibraryAccessFailureBlock)failure;

/**
 把视频写入指定相册

 @param videoUrl 视频地址
 @param albumName 相册名（Camera Roll 系列相册）
 @param completion 完成回调
 @param failure 失败回调
 */
- (void)dk_saveVideo:(NSURL *)videoUrl
          toAlbum:(NSString *)albumName
       completion:(ALAssetsLibraryWriteImageCompletionBlock)completion
          failure:(ALAssetsLibraryAccessFailureBlock)failure;

/**
 把 NSData类型的图片写入相册

 @param imageData 图片的 NSData
 @param albumName 相册名（Camera Rool 系列相册）
 @param metadata 元数据信息
 @param completion 完成回调
 @param failure 失败回调
 */
- (void)dk_saveImageData:(NSData *)imageData
              toAlbum:(NSString *)albumName
             metadata:(NSDictionary *)metadata
           completion:(ALAssetsLibraryWriteImageCompletionBlock)completion
              failure:(ALAssetsLibraryAccessFailureBlock)failure;

/**
 把 Asset写入相册

 @param assetURL Asset地址
 @param albumName 相册名（Camera Rool 系列相册）
 @param completion 完成回调
 @param failure 失败回调
 */
- (void)dk_addAssetURL:(NSURL *)assetURL
            toAlbum:(NSString *)albumName
         completion:(ALAssetsLibraryWriteImageCompletionBlock)completion
            failure:(ALAssetsLibraryAccessFailureBlock)failure;


/**
 获取关于这个相册你想要的属性信息（我猜是这个意思）

 @param property 属性名
 @param albumName 相册名
 @param completion 成功回调
 */
- (void)dk_loadAssetsForProperty:(NSString *)property
                    fromAlbum:(NSString *)albumName
                   completion:(void (^)(NSMutableArray *array, NSError *error))completion;

/**
 从相册中得到照片

 @param albumName 相册名
 @param completion 成功的回调
 */
- (void)dk_loadImagesFromAlbum:(NSString *)albumName
                 completion:(void (^)(NSMutableArray *images, NSError *error))completion;

@end
