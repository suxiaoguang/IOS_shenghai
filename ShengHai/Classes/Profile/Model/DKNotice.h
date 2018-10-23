//
//  DKNotice.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKNotice : NSObject
/** 消息id */
@property (nonatomic, copy) NSString *message_id;
/** 消息内容 */
@property (nonatomic, copy) NSString *message_content;
/** 是否已读 */
@property (nonatomic, copy) NSString *has_read;
/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;
@end
