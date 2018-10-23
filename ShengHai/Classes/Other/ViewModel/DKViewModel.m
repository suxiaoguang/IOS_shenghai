//
//  DKViewModel.m
//  TYGoods
//
//  Created by 庄槟豪 on 2017/3/20.
//  Copyright © 2017年 TY. All rights reserved.
//

#import "DKViewModel.h"

@interface DKViewModel ()
@property (nonatomic, strong) RACSubject *errors;
@property (nonatomic, strong) RACSubject *noMoreSubject;
@property (nonatomic, strong) RACCommand *loadDataCommand;
@end

@implementation DKViewModel

#pragma mark - Public

- (NSArray<RACCommand *> *)commands
{
    return nil;
}

- (void)setup {}

#pragma mark - Private

- (RACSubject *)errors
{
    if (!_errors) {
        _errors = [RACSubject subject];
    }
    return _errors;
}

- (RACSubject *)noMoreSubject
{
    if (!_noMoreSubject) {
        _noMoreSubject = [RACSubject subject];
    }
    return _noMoreSubject;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupBase];
    }
    return self;
}

- (void)setupBase
{
    [[RACSignal merge:[self errorSignals]] subscribe:self.errors];
    
    [self setup];
}

- (NSArray<RACSignal *> *)errorSignals
{
    NSArray<RACCommand *> *commands = [self commands];
    NSMutableArray<RACSignal *> *errorSignals = [NSMutableArray array];
    for (RACCommand *command in commands) {
        [errorSignals addObject:command.errors];
    }
    return errorSignals;
}

@end
