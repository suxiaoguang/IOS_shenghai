//
//  NSURL+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/11/23.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSURL (DKExtension)

/**
 获取视频的封面（URL 需要指向视频文件）

 @return 指向视频封面
 */
- (UIImage *)dk_fetchVideoCoverImage;

@end
