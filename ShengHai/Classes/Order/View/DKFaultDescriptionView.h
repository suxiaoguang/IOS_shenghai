//
//  DKFaultDescriptionView.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderBaseView.h"

@interface DKFaultDescriptionView : DKOrderBaseView

@property (weak, nonatomic) IBOutlet UILabel *contentLabel; // 内容label
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeight; // 内容高度
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

/** 图片浏览数组 */
@property (nonatomic, strong) NSMutableArray *mj_photos;

@end
