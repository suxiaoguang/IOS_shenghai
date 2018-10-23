//
//  DKOrderWikiSecond.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/5.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DKOrderWikiThird.h"

@interface DKOrderWikiSecond : NSObject<NSCoding>

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSMutableArray<DKOrderWikiThird *> *child;

@end
