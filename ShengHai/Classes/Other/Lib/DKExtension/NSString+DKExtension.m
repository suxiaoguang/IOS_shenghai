//
//  NSString+DKExtension.m
//  DKExtension
//
//  Created by Arclin on 16/7/30.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "NSString+DKExtension.h"

#import <objc/runtime.h>
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (DKExtension)

- (CGFloat)dk_heightWithContentWidth:(CGFloat)width font:(UIFont *)font
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    CGFloat height = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            attributes: @{NSFontAttributeName :font,
                                                                          NSParagraphStyleAttributeName : paragraphStyle}
                                                               context:nil].size.height;
    return height;

}

- (NSString *)dk_dateTimeWithLonglongTimeFormat:(NSString *)format
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self longLongValue]]];
    
    return currentDateStr;
}

- (NSDate *)dk_convertToDateWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}


+ (NSString *)dk_distanceWithTime:(NSString *)longLongTime
{
    // 以前时间
    const long agoTimeLong = (long)[longLongTime longLongValue];
    // 当前系统时间
    const long currentTimeLong = [[NSDate date] timeIntervalSince1970];
    
    const long distanceSecond = currentTimeLong - agoTimeLong;
    
    // 返回与现在的时间差
    if (distanceSecond >= 31104000) {
        return [NSString stringWithFormat:@"%ld年前",distanceSecond / 31104000];
    } else if (distanceSecond >= 2592000) {
        return [NSString stringWithFormat:@"%ld个月前",distanceSecond / 2592000];
    } else if (distanceSecond >= 86400) {
        return [NSString stringWithFormat:@"%ld天前",distanceSecond / 86400];
    } else if (distanceSecond >= 3600) {
        return [NSString stringWithFormat:@"%ld小时前",distanceSecond / 3600];
    } else if (distanceSecond >= 60) {
        return [NSString stringWithFormat:@"%ld分钟前",distanceSecond / 60];
    } else {
        return [NSString stringWithFormat:@"%ld秒前",distanceSecond];
    }
}

- (NSString *)dk_md5
{
    const char *cStr = [self UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5(cStr, (int)strlen(cStr), result);
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}

//解编码
- (NSString *)dk_decodeFromPercentEscapeString
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (instancetype)dk_hexStringWithDenary:(NSInteger)denary formatLength:(NSInteger)length
{
    NSString *nLetterValue;
    NSString *str = @"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig = denary % 16;
        denary = denary / 16;
        switch (ttmpig) {
            case 10:
                nLetterValue =@"A";
                break;
            case 11:
                nLetterValue =@"B";
                break;
            case 12:
                nLetterValue =@"C";
                break;
            case 13:
                nLetterValue =@"D";
                break;
            case 14:
                nLetterValue =@"E";
                break;
            case 15:
                nLetterValue =@"F";
                break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (denary == 0) {
            break;
        }
    }
    
    while (str.length < length) {
        str = [NSString stringWithFormat:@"0%@",str];
    }
    
    return str;
}

- (instancetype)dk_complementHexString
{
    // 字符串转char数组
    char hexChars[self.length];
    const char *str = [self cStringUsingEncoding:kCFStringEncodingUTF8];
    strcpy(hexChars,str);
    
    // 反码,按位取反
    NSMutableString *complementM = [NSMutableString string];
    for (int i = 0; i < self.length; i++) {
        int index = 0; // 十进制的索引
        if ((hexChars[i] >= 65 && hexChars[i] <= 70) || (hexChars[i] >= 97 && hexChars[i] <= 102)) { // A~F|a~f
            if (hexChars[i] <= 70) {
                index = 10 + hexChars[i] - 65;
            } else {
                index = 10 + hexChars[i] - 97;
            }
        } else { // 0~9
            index = hexChars[i] - 48;
        }
        index = 15 - index; // 转为补码的索引
        if (index > 9) { // A~F
            NSString *temp = nil;
            switch (index) {
                case 10:
                    temp = @"A";
                    break;
                case 11:
                    temp = @"B";
                    break;
                case 12:
                    temp = @"C";
                    break;
                case 13:
                    temp = @"D";
                    break;
                case 14:
                    temp = @"E";
                    break;
                case 15:
                    temp = @"F";
                    break;
            }
            [complementM appendFormat:@"%@",temp];
        } else { // 0~9
            [complementM appendFormat:@"%d",index];
        }
    }
    
    // 加一
    unsigned long hexValue = strtoul([complementM UTF8String],0,16) + 1;
    // 再转回十六进制
    NSString *result = [self dk_hexStringWithDenary:hexValue formatLength:4];
    
    return result;
}

+ (instancetype)dk_fileSizeToString:(unsigned long long)fileByteSize
{
    double convertedValue = (double)fileByteSize;
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"b",@"KB",@"MB",@"GB",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.1f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

+ (instancetype)dk_stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    va_list arglist;
    va_start(arglist, format);
    NSString *outStr = [[NSString alloc] initWithFormat:format arguments:arglist];
    va_end(arglist);
    
    return [outStr stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
}

- (NSString *)dk_pinYin
{
    // NSString转换为CFStringRef
    CFStringRef stringRef = (__bridge CFMutableStringRef)[NSMutableString stringWithString:self];
    // 汉字转换为拼音
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, stringRef);
    // 带声调符号的拼音
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    // 去掉声调符号
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    // CFStringRef转换为NSString
    NSMutableString *aNSString = (__bridge NSMutableString *)string;
    // 去掉空格
    NSString *finalString = [aNSString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c", 32] withString:@""];
    return finalString;
}

- (BOOL)dk_isPhoneNum
{
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

- (BOOL)dk_isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)dk_isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)dk_isHaveIllegalChar
{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@":;:[]{}（#%-*+=）\\|~(＜＞$%^&*)+"];
    NSRange range = [self rangeOfCharacterFromSet:doNotWant];
    return range.location<self.length;
}

@end
