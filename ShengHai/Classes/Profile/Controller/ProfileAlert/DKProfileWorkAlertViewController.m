//
//  DKProfileWorkAlertViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileWorkAlertViewController.h"

#import "DKProfileUserInfoViewModel.h"

@interface DKProfileWorkAlertViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) DKProfileUserInfoViewModel *vm;

@end

@implementation DKProfileWorkAlertViewController
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
    self.view.backgroundColor = [UIColor clearColor];
    if ([self.type isEqualToString:@"下班"]) {
        self.titleLabel.text = @"工作完成了,是否要下班?";
        [self.imageView setImage:[UIImage imageNamed:@"pic_out_work"]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.startWorkCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.workBlock(YES);
        DKSetUserDefault(@"isWorking", @"1");
        [self dismissViewControllerAnimated:NO completion:nil];
        [DKProgressHUD showSuccessWithStatus:@"上班成功"];
    }];
    
    [self.vm.outWorkCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.workBlock(NO);
        DKSetUserDefault(@"isWorking", @"0");
        [self dismissViewControllerAnimated:NO completion:nil];
        [DKProgressHUD showSuccessWithStatus:@"下班成功"];
    }];
}

- (void)event
{
    @weakify(self);
    [[self.cancleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       @strongify(self);
        if ([DKGetUserDefault(@"isWorking") isEqualToString:@"0"]) { // 未上班状态
            [self.vm.startWorkCommand execute:nil];
        } else { // 已上班
            [self.vm.outWorkCommand execute:nil];
        }
    }];
}

@end
