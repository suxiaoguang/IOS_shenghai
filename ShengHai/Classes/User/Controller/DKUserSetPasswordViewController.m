//
//  DKUserSetPasswordViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/21.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKUserSetPasswordViewController.h"

#import "DKUserLoginRegisterParams.h"

@interface DKUserSetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField    *passwordTextField;         // 密码输入框
@property (weak, nonatomic) IBOutlet UITextField    *completePasswordTextField; // 确认密码输入框
@property (weak, nonatomic) IBOutlet UIView         *backgroundView;            // 底部阴影
@property (weak, nonatomic) IBOutlet UIButton       *completeButton;            // 完成按钮

@end

@implementation DKUserSetPasswordViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKUserLoginRegisterViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setUpView];
    [self event];
}

- (void)setUpView
{
    switch (self.resetAccountType) {
        case DKSetPasswordTypeForgetPassword: { // 忘记密码设置密码
            self.navigationItem.title = @"设置密码";
            break;
        }
        case DKSetPasswordTypeChangePassword: { // 修改密码设置密码
            self.navigationItem.title = @"修改密码";
            break;
        }
    }
    [self.backgroundView dk_addShadowToView];
}

#pragma mark - events
- (void)bind
{
    RAC(self.vm.userLoginRegisterParams, wait_password) = self.passwordTextField.rac_textSignal;
    RAC(self.vm.userLoginRegisterParams, passwordNew) = self.completePasswordTextField.rac_textSignal;
    
    @weakify(self);
    [self.vm.userForgetCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
        self.completeButton.userInteractionEnabled = ![x boolValue];
    }];
    
    [self.vm.changePassworldCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
        self.completeButton.userInteractionEnabled = ![x boolValue];
    }];
    
    [self.vm.userForgetCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popToRootViewControllerAnimated:YES];
        [DKProgressHUD showSuccessWithStatus:@"成功找回"];
    }];
    
    [self.vm.changePassworldCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[DKNavigationController alloc] initWithRootViewController:[[DKUserLoginViewController alloc] init]];
        [DKProgressHUD showSuccessWithStatus:@"修改密码成功"];
    }];
}

- (void)event
{
    @weakify(self);
    [[self.completeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        switch (self.resetAccountType) {
            case DKSetPasswordTypeForgetPassword: { // 忘记密码设置密码
                [self.vm.userForgetCommand execute:nil];
                break;
            }
            case DKSetPasswordTypeChangePassword: { // 修改密码设置密码
                [self.vm.changePassworldCommand execute:nil];
                break;
            }
        }
    }];
}

@end
