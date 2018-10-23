//
//  DKFaultDescriptionView.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKFaultDescriptionView.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface DKFaultDescriptionView ()

@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *voiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;

@end

@implementation DKFaultDescriptionView
- (NSMutableArray *)mj_photos
{
    if (!_mj_photos) {
        _mj_photos = [NSMutableArray array];
    }
    return _mj_photos;
}

- (void)setOrder:(DKOrder *)order
{
    self.contentLabel.text = order.describe_text;
    self.voiceTimeLabel.text = [NSString dk_stringWithFormat:@"%ld",(long)ceilf(order.describe_voice_duration.floatValue)];
    
    [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:order.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            MJPhoto *p = [[MJPhoto alloc] init];
            p.image = image;
            p.index = 0;
            [self.mj_photos addObject:p];
        }
    }];
    [self.twoImageView sd_setImageWithURL:[NSURL URLWithString:order.image2] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            MJPhoto *p = [[MJPhoto alloc] init];
            p.image = image;
            p.index = 1;
            [self.mj_photos addObject:p];
        }
    }];
    [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:order.image3] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            MJPhoto *p = [[MJPhoto alloc] init];
            p.image = image;
            p.index = 2;
            [self.mj_photos addObject:p];
        }
    }];
    
    if (order.describe_voice.length) {
        self.voiceView.hidden = NO;
        self.voiceLabel.hidden = NO;
        self.voiceButton.userInteractionEnabled = YES;
    }
}

- (IBAction)clickImageViewButton:(UIButton *)sender {
    if (sender.tag <= self.mj_photos.count - 1) {
        [self showBrowserWithIndex:sender.tag];
    }
}

#pragma mark - private
- (void)showBrowserWithIndex:(NSInteger)index
{
    if(self.mj_photos.count > 0) {
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.photos = self.mj_photos;
        browser.currentPhotoIndex = index;
        [browser show];
    }
}

@end
