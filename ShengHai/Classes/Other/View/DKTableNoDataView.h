//
//  DKTableNoDataView.h
//  YouYunBao
//
//  Created by 庄槟豪 on 2017/6/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKTableNoDataView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;
+ (instancetype)noDataView;

@end
