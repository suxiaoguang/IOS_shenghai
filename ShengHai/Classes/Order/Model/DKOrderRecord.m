//
//  DKOrderRecord.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/28.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderRecord.h"

#import <YYText/YYText.h>

@implementation DKOrderRecord

- (CGFloat)rowHeight
{
    NSMutableAttributedString   *attributeStr = [self contentText];
    YYTextContainer             *container = [YYTextContainer containerWithSize:CGSizeMake(DKScreenW - 62, MAXFLOAT)];
    YYTextLayout                *textLayout = [YYTextLayout layoutWithContainer:container text:attributeStr];

    return textLayout.textBoundingSize.height + 2 * DKSmallMargin + 2;
}

- (NSMutableAttributedString *)contentText
{
    NSString    *normalText = self.text;                                                                // 普通文本
    NSString    *time = [NSDate dk_dateStrWithTimeStamp:self.timestamp format:@"yyyy-MM-dd HH:mm"];     // 时间
    NSString    *questType = self.quest_type;                                                           // quest 才有的 问题类型
    NSString    *fixPlan = self.fix_plan;                                                               // quest 才有的 解决方案
    NSString    *phone = self.tel;                                                                      // tel 才有的 电话号码

    // normal、tel、quest
    if ([self.type isEqualToString:@"normal"]) {
        NSString                    *str = [NSString dk_stringWithFormat:@"%@\n%@", normalText, time];
        NSMutableAttributedString   *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorFontGray range:[str rangeOfString:normalText]];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorFontGray range:[str rangeOfString:time]];
        attributeStr.yy_font = [UIFont systemFontOfSize:14.f];
        attributeStr.yy_lineSpacing = 5.f;
        return attributeStr;
    } else if ([self.type isEqualToString:@"tel"]) {
        NSString                    *str = [NSString dk_stringWithFormat:@"%@ %@\n%@", normalText, phone, time];
        NSMutableAttributedString   *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorFontGray range:[str rangeOfString:normalText]];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorTintMain range:[str rangeOfString:phone]];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorFontGray range:[str rangeOfString:time]];
        attributeStr.yy_font = [UIFont systemFontOfSize:14.f];
        attributeStr.yy_lineSpacing = 5.f;
        return attributeStr;
    } else {
        NSString                    *str = [NSString dk_stringWithFormat:@"问题类型 %@\n解决方案 %@ \n%@", questType, fixPlan, time];
        NSMutableAttributedString   *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorFontGray range:[str rangeOfString:@"问题类型"]];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorFontGray range:[str rangeOfString:@"解决方案"]];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorFontBlack range:[str rangeOfString:questType]];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorFontBlack range:[str rangeOfString:fixPlan]];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:DKColorFontGray range:[str rangeOfString:time]];
        attributeStr.yy_font = [UIFont systemFontOfSize:14.f];
        attributeStr.yy_lineSpacing = 5.f;
        return attributeStr;
    }
}

@end
