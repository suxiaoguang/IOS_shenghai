//
//  DKUncaughtExceptionHandler.m
//  QACloud
//
//  Created by Arclin on 16/10/31.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "DKUncaughtExceptionHandler.h"

#import "NSDate+DKExtension.h"
#import "DKHTTPTool.h"

#import <sys/utsname.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>

// 系统信号截获处理方法
void signalHandler(int signal);

// 异常截获处理方法
void exceptionHandler(NSException *exception);

const int32_t _uncaughtExceptionMaximum = 20;

NSString *const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString *const SingalExceptionHandlerAddressesKey = @"SingalExceptionHandlerAddressesKey";
NSString *const ExceptionHandlerAddressesKey = @"ExceptionHandlerAddressesKey";

void signalHandler(int signal)
{
    volatile int32_t    _uncaughtExceptionCount = 0;
    int32_t             exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);

    if (exceptionCount > _uncaughtExceptionMaximum) { // 如果太多不用处理
        return;
    }

    // 获取信息
    NSMutableDictionary *userInfo =
        [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];

    NSArray *callStack = [DKUncaughtExceptionHandler backtrace];
    [userInfo setObject:callStack forKey:SingalExceptionHandlerAddressesKey];

    // 现在就可以保存信息到本地［］
}

void exceptionHandler(NSException *exception)
{
    volatile int32_t    _uncaughtExceptionCount = 0;
    int32_t             exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);

    if (exceptionCount > _uncaughtExceptionMaximum) { // 如果太多不用处理
        return;
    }

    NSArray             *callStack = [DKUncaughtExceptionHandler backtrace];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:ExceptionHandlerAddressesKey];

    // 保存信息到本地
    NSString        *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"crash.plist"];
    struct utsname  systemInfo;
    uname(&systemInfo);

    NSDictionary *crashInfo = @{@"crash_time":[NSDate dk_currentDateStrWithFormat:@"yyyy-MM-dd HH:mm:ss"],
                                @"device_type": [DKUncaughtExceptionHandler deviceVersion:[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]],
                                @"device_system": [UIDevice currentDevice].systemVersion,
                                @"crash_type":exception.name,
                                @"crash_reason":exception.reason,
                                @"crash_stack":userInfo.descriptionInStringsFileFormat};
    [crashInfo writeToFile:path atomically:YES];
}

@implementation DKUncaughtExceptionHandler
// 获取调用堆栈
+ (NSArray *)backtrace
{
    void    *callstack[128];
    int     frames = backtrace(callstack, 128);
    char    **strs = backtrace_symbols(callstack, frames);

    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];

    for (int i = 0; i < frames; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }

    free(strs);

    return backtrace;
}

// 注册崩溃拦截
- (void)installExceptionHandler
{
    NSSetUncaughtExceptionHandler(&exceptionHandler);
    signal(SIGHUP, signalHandler);
    signal(SIGINT, signalHandler);
    signal(SIGQUIT, signalHandler);

    signal(SIGABRT, signalHandler);
    signal(SIGILL, signalHandler);
    signal(SIGSEGV, signalHandler);
    signal(SIGFPE, signalHandler);
    signal(SIGBUS, signalHandler);
    signal(SIGPIPE, signalHandler);
    #ifndef DEBUG
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"crash.plist"];

    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSDictionary *params = [[NSDictionary alloc] initWithContentsOfFile:path];

        [DKNetworkManager.post(@"http://test.dankal.cn/crashReporter/public/index.php/index/crash")
            .header(@{@"token":@"e6f8b1becbbba100c34444983fe3d3e1"})
            .params(params)
            .executeSignal subscribeNext:^(RACTuple *tuple) {
            DKHttpResponse *response = tuple.second;

            if (!response.error) {
                NSError *error;
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];

                if (error) {
                    DKLog(@"%@", error);
                }
            }
        }];
    }

    #endif
}

+ (NSString *)deviceVersion:(NSString *)deviceString
{
    // iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) {
        return @"iPhone 1G";
    }

    if ([deviceString isEqualToString:@"iPhone1,2"]) {
        return @"iPhone 3G";
    }

    if ([deviceString isEqualToString:@"iPhone2,1"]) {
        return @"iPhone 3GS";
    }

    if ([deviceString isEqualToString:@"iPhone3,1"]) {
        return @"iPhone 4";
    }

    if ([deviceString isEqualToString:@"iPhone3,2"]) {
        return @"Verizon iPhone 4";
    }

    if ([deviceString isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4S";
    }

    if ([deviceString isEqualToString:@"iPhone5,1"]) {
        return @"iPhone 5";
    }

    if ([deviceString isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5";
    }

    if ([deviceString isEqualToString:@"iPhone5,3"]) {
        return @"iPhone 5C";
    }

    if ([deviceString isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5C";
    }

    if ([deviceString isEqualToString:@"iPhone6,1"]) {
        return @"iPhone 5S";
    }

    if ([deviceString isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5S";
    }

    if ([deviceString isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus";
    }

    if ([deviceString isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    }

    if ([deviceString isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s";
    }

    if ([deviceString isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6s Plus";
    }

    if ([deviceString isEqualToString:@"iPhone8,4"]) {
        return @"iPhone SE";
    }

    if ([deviceString isEqualToString:@"iPhone9,1"]) {
        return @"iPhone 7";
    }

    if ([deviceString isEqualToString:@"iPhone9,3"]) {
        return @"iPhone 7";
    }

    if ([deviceString isEqualToString:@"iPhone9,2"]) {
        return @"iPhone 7 Plus";
    }

    if ([deviceString isEqualToString:@"iPhone9,4"]) {
        return @"iPhone 7 Plus";
    }

    // iPod
    if ([deviceString isEqualToString:@"iPod1,1"]) {
        return @"iPod Touch 1G";
    }

    if ([deviceString isEqualToString:@"iPod2,1"]) {
        return @"iPod Touch 2G";
    }

    if ([deviceString isEqualToString:@"iPod3,1"]) {
        return @"iPod Touch 3G";
    }

    if ([deviceString isEqualToString:@"iPod4,1"]) {
        return @"iPod Touch 4G";
    }

    if ([deviceString isEqualToString:@"iPod5,1"]) {
        return @"iPod Touch 5G";
    }

    // iPad
    if ([deviceString isEqualToString:@"iPad1,1"]) {
        return @"iPad";
    }

    if ([deviceString isEqualToString:@"iPad2,1"]) {
        return @"iPad 2 (WiFi)";
    }

    if ([deviceString isEqualToString:@"iPad2,2"]) {
        return @"iPad 2 (GSM)";
    }

    if ([deviceString isEqualToString:@"iPad2,3"]) {
        return @"iPad 2 (CDMA)";
    }

    if ([deviceString isEqualToString:@"iPad2,4"]) {
        return @"iPad 2 (32nm)";
    }

    if ([deviceString isEqualToString:@"iPad2,5"]) {
        return @"iPad mini (WiFi)";
    }

    if ([deviceString isEqualToString:@"iPad2,6"]) {
        return @"iPad mini (GSM)";
    }

    if ([deviceString isEqualToString:@"iPad2,7"]) {
        return @"iPad mini (CDMA)";
    }

    if ([deviceString isEqualToString:@"iPad3,1"]) {
        return @"iPad 3(WiFi)";
    }

    if ([deviceString isEqualToString:@"iPad3,2"]) {
        return @"iPad 3(CDMA)";
    }

    if ([deviceString isEqualToString:@"iPad3,3"]) {
        return @"iPad 3(4G)";
    }

    if ([deviceString isEqualToString:@"iPad3,4"]) {
        return @"iPad 4 (WiFi)";
    }

    if ([deviceString isEqualToString:@"iPad3,5"]) {
        return @"iPad 4 (4G)";
    }

    if ([deviceString isEqualToString:@"iPad3,6"]) {
        return @"iPad 4 (CDMA)";
    }

    if ([deviceString isEqualToString:@"iPad4,1"]) {
        return @"iPad Air";
    }

    if ([deviceString isEqualToString:@"iPad4,2"]) {
        return @"iPad Air";
    }

    if ([deviceString isEqualToString:@"iPad4,3"]) {
        return @"iPad Air";
    }

    if ([deviceString isEqualToString:@"iPad5,3"]) {
        return @"iPad Air 2";
    }

    if ([deviceString isEqualToString:@"iPad5,4"]) {
        return @"iPad Air 2";
    }

    if ([deviceString isEqualToString:@"i386"]) {
        return @"Simulator";
    }

    if ([deviceString isEqualToString:@"x86_64"]) {
        return @"Simulator";
    }

    if ([deviceString isEqualToString:@"iPad4,4"]
        || [deviceString isEqualToString:@"iPad4,5"]
        || [deviceString isEqualToString:@"iPad4,6"]) {
        return @"iPad mini 2";
    }

    if ([deviceString isEqualToString:@"iPad4,7"]
        || [deviceString isEqualToString:@"iPad4,8"]
        || [deviceString isEqualToString:@"iPad4,9"]) {
        return @"iPad mini 3";
    }

    return deviceString;
}

@end
