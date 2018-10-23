//
//  DKUserForgetViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/20.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKUserForgetViewController.h"
#import "DKUserSetPasswordViewController.h"

#import "DKUserLoginRegisterViewModel.h"

#import "DKUserLoginRegisterParams.h"

@interface DKUserForgetViewController ()

@property (weak, nonatomic) IBOutlet UIView         *forgetBackgroundView;      // 忘记密码底部View
@property (weak, nonatomic) IBOutlet UITextField    *phoneTextField;            // 手机号输入框
@property (weak, nonatomic) IBOutlet UITextField    *verificationCodeTextField; // 验证码输入框
@property (weak, nonatomic) IBOutlet UIButton       *fetchCodeButton;           // 获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton       *nextButton;                // 下一步按钮

@property (nonatomic, assign) NSInteger leftTime;                               // 剩余秒数

@property (nonatomic, strong) DKUserLoginRegisterViewModel *vm;                 // vm

@end

@implementation DKUserForgetViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKUserLoginRegisterViewModel)

- (void)setType:(NSString *)type
{
    _type = type;
    self.vm.userLoginRegisterParams.sms_type = _type;
}

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setUpView];
    [self event];
}

- (void)setUpView
{
    [self.forgetBackgroundView dk_addShadowToView];
    
    switch (self.resetAccountType) {
        case DKResetAccountTypeForgetPassword: {
            self.navigationItem.title = @"忘记密码";
            break;
        }
        case DKResetAccountTypeChangePhone: {
            self.navigationItem.title = @"更绑手机号";
            self.phoneTextField.placeholder = @"请输入更绑手机号码";
            [self.nextButton setTitle:@"完成" forState:UIControlStateNormal];
            break;
        }
    }
    
}

#pragma mark - events
- (void)bind
{
    RAC(self.vm.userLoginRegisterParams, staff_phone) = self.phoneTextField.rac_textSignal;
    RAC(self.vm.userLoginRegisterParams, code) = self.verificationCodeTextField.rac_textSignal;
    
    @weakify(self);
    [self.vm.changePhoneCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
        self.nextButton.userInteractionEnabled = ![x boolValue];
    }];
    
    [self.vm.validateCodeCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
        self.nextButton.userInteractionEnabled = ![x boolValue];
    }];
    
    [self.vm.sendSmsCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
        self.nextButton.userInteractionEnabled = ![x boolValue];
    }];
    
    [self.vm.sendSmsCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [DKProgressHUD showSuccessWithStatus:@"发送成功"];
        [self countDown];
    }];
    
    [self.vm.validateCodeCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        DKUserSetPasswordViewController *vc = [[DKUserSetPasswordViewController alloc] init];
        vc.resetAccountType = DKSetPasswordTypeForgetPassword;
        vc.vm = self.vm;
        [self.navigationController pushViewController:vc animated:YES];
        [DKProgressHUD showSuccessWithStatus:@"验证成功"];
    }];
    
    [self.vm.changePhoneCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popToRootViewControllerAnimated:YES];
        DKUserInfoCache.staff_phone = self.vm.userLoginRegisterParams.staff_phone;
        [[NSNotificationCenter defaultCenter] postNotificationName:DKUserInfoDidUpdatedNotification object:nil];
        [DKProgressHUD showSuccessWithStatus:@"更绑手机号成功"];
    }];
}

- (void)event
{
    @weakify(self);
    [[self.nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        switch (self.resetAccountType) {
            case DKResetAccountTypeForgetPassword: {
                [self.vm.validateCodeCommand execute:nil];
                break;
            }
            case DKResetAccountTypeChangePhone: {
                [self.vm.changePhoneCommand execute:nil];
                break;
            }
        }
    }];

    [[self.fetchCodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.vm.sendSmsCommand execute:nil];
    }];
}

#pragma mark - private
// 倒计时
- (void)countDown
{
    self.leftTime = (NSInteger)[[NSDate date] timeIntervalSince1970] + 30;
    self.fetchCodeButton.userInteractionEnabled = NO;
    [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] take:30] subscribeNext:^(id x) {
        [self.fetchCodeButton setBackgroundColor:DKColorLineGray];
        [self.fetchCodeButton setTitle:[NSString dk_stringWithFormat:@"%lds后重新发送", (long)(self.leftTime - (int)[[NSDate date] timeIntervalSince1970])] forState:UIControlStateNormal];

        if ((self.leftTime - (NSInteger)[[NSDate date] timeIntervalSince1970]) < 1) {
            [self.fetchCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.fetchCodeButton setBackgroundColor:DKColorTintMain];
            self.fetchCodeButton.userInteractionEnabled = YES;
        }
    }];
}

@end
