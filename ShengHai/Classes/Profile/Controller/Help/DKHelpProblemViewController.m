//
//  DKHelpProblemViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/11.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKHelpProblemViewController.h"
#import "DKProfileHelpViewModel.h"

@interface DKHelpProblemViewController ()
@property (nonatomic, strong) DKProfileHelpViewModel *vm;
@end

@implementation DKHelpProblemViewController
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
    self.navigationItem.title = @"常见问题";
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.fetchQuestionsCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.h5Content = x;
    }];
}

- (void)event
{
    [self.vm.fetchQuestionsCommand execute:nil];
}

@end
