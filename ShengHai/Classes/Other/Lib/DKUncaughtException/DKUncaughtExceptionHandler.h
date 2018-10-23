//
//  DKUncaughtExceptionHandler.h
//  QACloud
//
//  Created by Arclin on 16/10/31.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKUncaughtExceptionHandler : NSObject

- (void)installExceptionHandler;
+ (NSString*) deviceVersion:(NSString *)deviceString;
+ (NSArray *)backtrace;

@end

