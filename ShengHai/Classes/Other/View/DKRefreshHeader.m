//
//  DKRefreshHeader.m
//  YouYunBao
//
//  Created by 庄槟豪 on 16/8/20.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKRefreshHeader.h"

@interface DKRefreshHeader ()
@end

@implementation DKRefreshHeader

/** 初始化 */
- (void)prepare
{
    [super prepare];
    
    self.stateLabel.hidden = NO;
    self.lastUpdatedTimeLabel.hidden = YES;
    self.automaticallyChangeAlpha = YES;
}

/** 布局子控件 */
- (void)placeSubviews
{
    [super placeSubviews];
}

@end
