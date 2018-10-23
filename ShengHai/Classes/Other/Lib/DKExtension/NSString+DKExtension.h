//
//  NSString+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/7/30 庄槟豪 on 16/5/11.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (DKExtension)

#pragma mark - View 相关

/**
 计算字符串高度

 @param width 宽度
 @param font 字体
 @return 高度
 */
- (CGFloat)dk_heightWithContentWidth:(CGFloat)width font:(UIFont *)font;

#pragma mark - 日期相关

/**
 时间戳转日期 NSString

 @param format 日期格式
 @return 日期
 
*/
- (NSString *)dk_dateTimeWithLonglongTimeFormat:(NSString *)format;

/**
 NSString 转 NSDate

 @param format 日期格式
 @return NSDate
 */
- (NSDate *)dk_convertToDateWithFormat:(NSString *)format;

/**
 返回一个字符串的时间距离 eg:10分钟前 / 1小时前
 
 @param longLongTime 时间戳
 @return 时间戳距当前时间的距离
 */
+ (NSString *)dk_distanceWithTime:(NSString *)longLongTime;


#pragma mark - 进制相关

/**
　十进制转十六进制

 @param denary 十进制整型
 @param length 十六进制长度
 @return 十六进制字符串
 */
- (instancetype)dk_hexStringWithDenary:(NSInteger)denary formatLength:(NSInteger)length;

/**
 十六进制字符串转补码
 */
- (instancetype)dk_complementHexString;

#pragma mark - 加密 / 解码 相关

/**
 MD5 加密
 
 @return MD5 String
 */
- (NSString *)dk_md5;

/**
 解码url编码

 @return 解码后的字符串
 */
- (NSString *)dk_decodeFromPercentEscapeString;

#pragma mark - 文件操作相关

/**
 把比特数转为需要的内存表现形式

 @param fileByteSize 比特数
 @return 表示内存的字符串
 */
+ (instancetype)dk_fileSizeToString:(unsigned long long)fileByteSize;


#pragma mark - 文本相关

/**
 格式化字符串，并过滤格式化后的字符串中的(null)

 @param format 格式
 @return 格式化后，过滤掉@"(null)"的字符串
 */
+ (instancetype)dk_stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 获得拼音

 @return 拼音字符串
 */
- (NSString *)dk_pinYin;

#pragma mark - 验证合法性相关

/**
 是否正确电话号码 (中国大陆)

 @return  YES/NO
 */
- (BOOL)dk_isPhoneNum;

/**
 是否正确 Email格式

 @return  YES/NO
 */
- (BOOL)dk_isEmail;

/**
 是否纯数字

 @return  YES/NO
 */
- (BOOL)dk_isPureInt;


/**
 是否含有特殊字符

 @return YES/NO
 */
- (BOOL)dk_isHaveIllegalChar;

@end
