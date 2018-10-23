//
//  NSObject+DKExtension.m
//  DKExtension
//
//  Created by 庄槟豪 on 16/5/25.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "NSObject+DKExtension.h"

#import <objc/runtime.h>

@implementation NSObject (DKExtension)

+ (instancetype)dk_modelWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict
{
    return [[self alloc] initWithDict:dict mapDict:mapDict];
}

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

- (instancetype)initWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict
{
    // 记录属性个数
    unsigned int count = 0;
    // 获取模型的所有属性
    Ivar *ivars = class_copyIvarList([self class], &count);
    // 遍历模型中属性
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        // 获取属性名
        NSString *ivarName = @(ivar_getName(ivar));
        // 去掉下划线
        ivarName = [ivarName substringFromIndex:1];
        // 获取值
        id value = dict[ivarName];
        if (value == nil) {
            if (mapDict) {
                // 从映射字典中取出替代的key
                NSString *keyName = mapDict[ivarName];
                // 在原字典中用替代的key取出值
                value = dict[keyName];
            }
        }
        // 赋值
        [self setValue:value forKey:ivarName];
    }
    return self;
}

+ (instancetype)dk_modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *ivarName = @(ivar_getName(ivar));
        ivarName = [ivarName substringFromIndex:1];
        id value = dict[ivarName];
        [self setValue:value forKey:ivarName];
    }
    return self;
}

- (void)dk_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
