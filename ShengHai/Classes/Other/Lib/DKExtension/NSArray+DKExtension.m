//
//  NSArray+DKExtension.m
//  DKExtension
//
//  Created by Arclin on 16/10/31.
//  Edited by 庄槟豪 on 16/12/31.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "NSArray+DKExtension.h"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@implementation NSArray (DKExtension)

- (NSArray *)dk_fetchPropertys:(NSString *)propertyName {
    NSMutableArray *propertyLists = [NSMutableArray array];
    for (id object in self) {
        unsigned int count = 0;
        objc_property_t *properties  =class_copyPropertyList([object class], &count);
        for (int i = 0; i < count; i++) {
            const char* name = property_getName(properties[i]);
            NSString *ivarName = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
            if([ivarName isEqualToString:propertyName]) {
                // 获取值
                id value = [object valueForKey:ivarName];
                [propertyLists addObject:value];
                break;
            }
        }
        free(properties);
    }
    return propertyLists;
}

/**
 重写系统放，控制台打印中文
 */
- (NSString *)descriptionWithLocale:(id)locale
{
    // 控制台打印中文
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"[\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    [string appendString:@"]"];
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

@end
