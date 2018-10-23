//
//  DKProfileSuccessAlertViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileSuccessAlertViewController.h"

#import "DKProfileUserInfoViewModel.h"

@interface DKProfileSuccessAlertViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) DKProfileUserInfoViewModel *vm;

@end

@implementation DKProfileSuccessAlertViewController
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
	self.titleLabel.text = self.successText;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - events
- (void)event
{
    @weakify(self);
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       @strongify(self);
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end
