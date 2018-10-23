//
//  DKOrderWikiFirst.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/5.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DKOrderWikiSecond.h"

@interface DKOrderWikiFirst : NSObject<NSCoding>

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSMutableArray<DKOrderWikiSecond *> *child;

@end
