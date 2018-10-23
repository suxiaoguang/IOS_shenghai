//
//  DKProfileFeedbackViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/21.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileFeedbackViewController.h"

#import "DKProfileUserInfoViewModel.h"

@interface DKProfileFeedbackViewController ()

@property (nonatomic, strong) DKProfileUserInfoViewModel *vm;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end

@implementation DKProfileFeedbackViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKProfileUserInfoViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"意见反馈";
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.feedbackCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
        [DKProgressHUD showSuccessWithStatus:@"提交成功"];
    }];
}

- (void)event
{
    @weakify(self);
    [[self.commitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (!self.textView.text.length) {
            [DKProgressHUD showErrorWithStatus:@"意见反馈不能为空"];
			return;
        }
        [self.vm.feedbackCommand execute:self.textView.text];
    }];
}

@end
