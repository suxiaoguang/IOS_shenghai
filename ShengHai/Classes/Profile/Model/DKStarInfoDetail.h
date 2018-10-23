//
//  DKStarInfoDetail.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKStarInfoDetail : NSObject

/** id */
@property (nonatomic, copy) NSString *order_id;
/** 星星1 */
@property (nonatomic, copy) NSString *comment_star_1;
/** 星星2 */
@property (nonatomic, copy) NSString *comment_star_2;
/** 星星3 */
@property (nonatomic, copy) NSString *comment_star_3;
/** 评论内容 */
@property (nonatomic, copy) NSString *comment_text;
/** 该评论是否已读 */
@property (nonatomic, copy) NSString *comment_has_read;
/** 评论时间 */
@property (nonatomic, copy) NSString *comment_time;

@end
