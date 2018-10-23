//
//  NSArray+DKExtension.h
//  DKExtension
//
//  Created by Arclin on 16/10/31.
//  Edited by 庄槟豪 on 16/12/31.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DKExtension)

/**
 取出模型数组中某个属性组成数组
 
 @param propertyName 要取出的属性名
 @return 属性值组成的数组
 */
- (NSArray *)dk_fetchPropertys:(NSString *)propertyName;

@end
