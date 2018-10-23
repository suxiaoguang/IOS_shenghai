//
//  DKNoticeBarButtonItemView.h
//  YouYunBao
//
//  Created by 庄槟豪 on 2017/4/12.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKNoticeBarButtonItemView : UIView
@property (weak, nonatomic) IBOutlet UIView *smallRedView;

+ (instancetype)messageNoticView;

- (IBAction)noticeBtnClick;
@end
