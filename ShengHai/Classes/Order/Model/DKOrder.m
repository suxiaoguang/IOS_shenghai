//
//  DKOrder.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrder.h"

@implementation DKOrder

- (void)setDescribe_images:(NSString *)describe_images
{
    if (describe_images.length) {
        NSArray *imageArray = [describe_images componentsSeparatedByString:@";"];
        [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                self.image1  = imageArray[idx];
            } else if (idx == 1) {
                self.image2  = imageArray[idx];
            } else if (idx == 2) {
                self.image3  = imageArray[idx];
            }
        }];
        
        _describe_images = describe_images;
    }
}

@end
