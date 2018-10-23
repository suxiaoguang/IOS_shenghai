//
//  DKOrderRecord.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKOrderRecord : NSObject

/** 文本 */
@property (nonatomic, copy) NSString *text;
/** 3种：normal、tel、quest */
@property (nonatomic, copy) NSString *type;
/** 时间 */
@property (nonatomic, copy) NSString *timestamp;
/** quest 才有的 问题类型 */
@property (nonatomic, copy) NSString *quest_type;
/** quest 才有的 解决方案 */
@property (nonatomic, copy) NSString *fix_plan;
/** tel 才有的 电话号码 */
@property (nonatomic, copy) NSString *tel;

- (NSMutableAttributedString *)contentText;
- (CGFloat)rowHeight;

@end
