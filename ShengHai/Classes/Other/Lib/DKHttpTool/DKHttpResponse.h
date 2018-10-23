//
//  DKHttpResponse.h
//  DKNetworking
//
//  Created by 庄槟豪 on 2017/3/9.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DKNetworking/DKNetworkResponse.h>

@interface DKHttpResponse : DKNetworkResponse

/** 状态码 */
@property (nonatomic, copy) NSString *code;
/** 说明 */
@property (nonatomic, copy) NSString *message;
/** 结果 */
@property (nonatomic, copy) id data;
@end
