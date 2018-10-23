//
//  DKUserChangePhoneViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKUserChangePhoneViewController.h"
#import "DKUserForgetViewController.h"
#import "DKUserSetPasswordViewController.h"

#import "DKUserLoginRegisterViewModel.h"
#import "DKUserLoginRegisterParams.h"

@interface DKUserChangePhoneViewController ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) DKUserLoginRegisterViewModel *vm; // vm

@end

@implementation DKUserChangePhoneViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKUserLoginRegisterViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    switch (self.changeType) {
        case DKChangeTypePhone: {
            self.navigationItem.title = @"更绑手机号";
            break;
        }
        case DKChangeTypePassword: {
            self.navigationItem.title = @"修改密码";
            self.titleLabel.text = @"旧密码";
            self.phoneTextField.placeholder = @"请输入旧密码";
            break;
        }
    }
    
    [self.backgroundView dk_addShadowToView];
}

#pragma mark - events
- (void)bind
{
    RAC(self.vm.userLoginRegisterParams, old_phone) = self.phoneTextField.rac_textSignal;
    RAC(self.vm.userLoginRegisterParams, old_password) = self.phoneTextField.rac_textSignal;
    
    @weakify(self);
    [self.vm.validatePhoneCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
        self.nextButton.userInteractionEnabled = ![x boolValue];
    }];
    
    [self.vm.validatePassworldCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
        self.nextButton.userInteractionEnabled = ![x boolValue];
    }];
    
    [self.vm.validatePhoneCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        DKUserForgetViewController *vc = [[DKUserForgetViewController alloc] init];
        vc.resetAccountType = DKResetAccountTypeChangePhone;
        vc.type = @"bind";
        [self.navigationController pushViewController:vc animated:YES];
        [DKProgressHUD showSuccessWithStatus:@"手机号正确"];
    }];
    
    [self.vm.validatePassworldCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        DKUserSetPasswordViewController *vc = [[DKUserSetPasswordViewController alloc] init];
        vc.resetAccountType = DKSetPasswordTypeChangePassword;
        vc.vm = self.vm;
        [self.navigationController pushViewController:vc animated:YES];
        [DKProgressHUD showSuccessWithStatus:@"密码正确"];
    }];
}

- (void)event
{
    @weakify(self);
    [[self.nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        switch (self.changeType) {
            case DKChangeTypePhone: {
                [self.vm.validatePhoneCommand execute:nil];
                break;
            }
            case DKChangeTypePassword: {
                [self.vm.validatePassworldCommand execute:nil];
                break;
            }
        }
    }];
}

@end
