//
//  NSURL+DKExtension.m
//  DKExtension
//
//  Created by Arclin on 16/11/23.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "NSURL+DKExtension.h"
#import <AVFoundation/AVFoundation.h>

@implementation NSURL (DKExtension)

- (UIImage *)dk_fetchVideoCoverImage
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:self options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(320, 480);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(2, 1) actualTime:NULL error:&error];
    UIImage *image = [UIImage imageWithCGImage: img];
    return image;
}

@end
