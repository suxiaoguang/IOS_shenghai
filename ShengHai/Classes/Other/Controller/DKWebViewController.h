//
//  DKWebViewController.h
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/12/24.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKWebViewController : DKViewController
/** 加载url */
@property (nonatomic, copy) NSString *url;
/** 加载html代码 */
@property (nonatomic, copy) NSString *h5Content;

- (instancetype)initWithUrl:(NSString *)url;
- (instancetype)initWithH5Content:(NSString *)h5Content;

+ (instancetype)webViewWithUrl:(NSString *)url;
+ (instancetype)webViewWithH5Content:(NSString *)h5Content;

@end
