//
//  DKContactInformation.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/11.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKContactInformation : NSObject

/** 微信二维码链接 */
@property (nonatomic, copy) NSString *wechat;
/** 手机号码 */
@property (nonatomic, copy) NSString *phone;

@end
