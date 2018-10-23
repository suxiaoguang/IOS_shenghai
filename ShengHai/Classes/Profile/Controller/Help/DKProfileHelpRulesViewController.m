//
//  DKProfileHelpRulesViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileHelpRulesViewController.h"

#import "DKProfileHelpViewModel.h"

@interface DKProfileHelpRulesViewController ()
@property (nonatomic, strong) DKProfileHelpViewModel *vm;
@end

@implementation DKProfileHelpRulesViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKProfileHelpViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"平台规则";
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.fetchRulesCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.h5Content = x;
    }];
}

- (void)event
{
    [self.vm.fetchRulesCommand execute:nil];
}

@end
