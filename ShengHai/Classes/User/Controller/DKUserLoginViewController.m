//
//  DKUserLoginViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/17.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKUserLoginViewController.h"
#import "DKUserForgetViewController.h"

#import "DKUserLoginRegisterViewModel.h"
#import "JPUSHService.h"

#import "DKUserLoginRegisterParams.h"

@interface DKUserLoginViewController ()

@property (weak, nonatomic) IBOutlet UIView         *loginBackgroundView;   // 登录底部
@property (weak, nonatomic) IBOutlet UITextField    *accountTextField;      // 工号
@property (weak, nonatomic) IBOutlet UITextField    *passwordTextField;     // 密码
@property (weak, nonatomic) IBOutlet UIButton       *loginButton;           // 登录
@property (weak, nonatomic) IBOutlet UIButton       *forgetButton;          // 忘记密码?

@property (nonatomic, strong) DKUserLoginRegisterViewModel *vm;             // vm

@end

@implementation DKUserLoginViewController
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
    self.fd_prefersNavigationBarHidden = YES;
    [self.loginBackgroundView dk_addShadowToView];
}

#pragma mark - events
- (void)bind
{
    RAC(self.vm.userLoginRegisterParams, staff_code) = self.accountTextField.rac_textSignal;
    RAC(self.vm.userLoginRegisterParams, password) = self.passwordTextField.rac_textSignal;
    
    
    @weakify(self);
    // 登录
    [self.vm.loginCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
        self.loginButton.userInteractionEnabled = ![x boolValue];
    }];
    [self.vm.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
//        @strongify(self);
        [UIApplication sharedApplication].keyWindow.rootViewController = [[DKTabBarController alloc] init];
        [DKProgressHUD showSuccessWithStatus: @"登录成功"];
        [JPUSHService setAlias:[NSString dk_stringWithFormat:@"hd_staff_%@",DKUserInfoCache.staff_id] callbackSelector:nil object:nil];
    }];
}

- (void)event
{
    @weakify(self);
    [[self.forgetButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        DKUserForgetViewController *vc = [[DKUserForgetViewController alloc] init];
        vc.type = @"forgot";
        vc.resetAccountType = DKResetAccountTypeForgetPassword;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.vm.loginCommand execute: nil];
        DKLog(@"点击登录");
    }];
}

@end
