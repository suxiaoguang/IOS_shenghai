//
//  DKPauseOrderViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKPauseOrderViewController.h"

#import "DKOrderDetailViewModel.h"

@interface DKPauseOrderViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic, strong) DKOrderDetailViewModel *vm;

@end

@implementation DKPauseOrderViewController
static NSString * const kPlanHolderText = @"请填写暂停原因...";

#pragma mark - setters && getters
DKRegisterViewModel(vm, DKOrderDetailViewModel)

- (void)setOrderId:(NSString *)orderId
{
    _orderId = orderId;
    self.vm.orderId = orderId;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.textView.delegate = self;
    self.textView.text = kPlanHolderText;
    self.textView.textColor = [UIColor lightGrayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private
- (IBAction)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.pauseOrderCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.callBackBlock(YES);
        [self dismissViewControllerAnimated:YES completion:nil];
        [DKProgressHUD showSuccessWithStatus:@"暂停订单成功"];
    }];
}

- (void)event
{
    @weakify(self);
    [[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.vm.pauseReason = [self.textView.text isEqualToString:kPlanHolderText] ? @"" : self.textView.text;
        [self.vm.pauseOrderCommand execute:nil];
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:kPlanHolderText]) {
        textView.text = @"";
        textView.textColor = [UIColor darkGrayColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (!textView.text.length) {
        textView.text = kPlanHolderText;
        textView.textColor = [UIColor lightGrayColor];
    }
}


@end
