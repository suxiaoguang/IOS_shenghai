//
//  NSObject+DKExtension.h
//  DKExtension
//
//  Created by 庄槟豪 on 16/5/25.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DKExtension)

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @param mapDict 映射字典
 *
 *  @return 返回属性已赋值的模型
 */
+ (instancetype)dk_modelWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @param mapDict 映射字典
 *  @return 返回属性已赋值的模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @return 返回属性已赋值的模型
 */
+ (instancetype)dk_modelWithDict:(NSDictionary *)dict;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @return 返回属性已赋值的模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 方法交换

 @param origSelector 方法1
 @param newSelector 方法2
 */
- (void)dk_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector;

@end
