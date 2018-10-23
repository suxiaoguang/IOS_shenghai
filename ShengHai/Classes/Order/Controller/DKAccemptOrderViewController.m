//
//  DKAccemptOrderViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKAccemptOrderViewController.h"

#import "DKOrderDetailViewModel.h"

@interface DKAccemptOrderViewController ()

@property (weak, nonatomic) IBOutlet UIButton   *closeButton;           // 关闭按钮
@property (weak, nonatomic) IBOutlet UIButton   *completeButton;        // 完成按钮

@property (weak, nonatomic) IBOutlet UIButton       *currentDealButton; // 即刻处理按钮
@property (weak, nonatomic) IBOutlet UIImageView    *currentDealImageView;

@property (weak, nonatomic) IBOutlet UIButton       *appointDealButton; // 预约处理按钮
@property (weak, nonatomic) IBOutlet UIImageView    *appointDealImageView;

@property (weak, nonatomic) IBOutlet UIView *dealLineView;                          // 处理横线

@property (weak, nonatomic) IBOutlet UITextField        *appointTimeTextField;      // 预约时间输入框
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appointTimeViewHeightCons; // 预约时间高度约束  70
@property (weak, nonatomic) IBOutlet UIView             *appointTimeView;           // 预约时间底
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backGroundViewHeightCons;  // 底部高度约束 240

@property (nonatomic, strong) UIDatePicker *datePicker;                             // 时间选择器

@property (nonatomic, strong) DKOrderDetailViewModel *vm; // vm

@property (nonatomic, copy) NSString *timeIntervalStr; // 预约时间戳

@end

@implementation DKAccemptOrderViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKOrderDetailViewModel)

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [NSDate date];
		_datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:259200];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    }
    return _datePicker;
}

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
    
    self.backGroundViewHeightCons.constant = 170;
    self.appointTimeViewHeightCons.constant = 0;
    self.appointTimeView.hidden = YES;
    self.dealLineView.hidden = YES;
    
    self.currentDealImageView.highlighted = YES;
    self.vm.appointTime = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    
    [self setupDatePicker:self.appointTimeTextField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private
// 设置时间选择器
- (void)setupDatePicker:(UITextField *)textField
{
    textField.inputView = self.datePicker;
    // 设置datePicker工具条
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnClick)];
    toolBar.items = @[flex,done];
    textField.inputAccessoryView = toolBar;
}

// 点击完成时间选择
- (void)doneBtnClick
{
    [self.view endEditing:YES];
    NSDate *date = [self.datePicker date];
    NSTimeInterval timeInterval = (long)[date timeIntervalSince1970];
    self.timeIntervalStr = [NSString stringWithFormat:@"%f",timeInterval];
    self.appointTimeTextField.text = [NSDate dk_dateStrWithTimeStamp:self.timeIntervalStr format:@"yyyy-MM-dd HH:mm"];
    self.vm.appointTime = self.timeIntervalStr;
}

- (IBAction)clickDetalButton:(id)sender {
    [self.view endEditing:YES];
    
    self.currentDealImageView.highlighted = sender == self.currentDealButton ? YES : NO;
    self.appointDealImageView.highlighted = sender == self.appointDealButton ? YES : NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        if (self.currentDealImageView.highlighted) {
            self.vm.appointTime = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
            
            self.backGroundViewHeightCons.constant = 170;
            self.appointTimeViewHeightCons.constant = 0;
            self.appointTimeView.hidden = YES;
            self.dealLineView.hidden = YES;
        } else {
            self.vm.appointTime = self.timeIntervalStr.length ? self.timeIntervalStr : nil;
            
            self.backGroundViewHeightCons.constant = 240;
            self.appointTimeViewHeightCons.constant = 70;
            self.appointTimeView.hidden = NO;
            self.dealLineView.hidden = NO;
        }
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.dealOrderCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.dealBlock(YES);
        [self dismissViewControllerAnimated:YES completion:nil];
        [DKProgressHUD showSuccessWithStatus:@"接受订单成功"];
    }];
    
    [self.vm.appointOrderCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.dealBlock(YES);
        [self dismissViewControllerAnimated:YES completion:nil];
        [DKProgressHUD showSuccessWithStatus:@"接受订单成功"];
    }];
}

- (void)event
{
    @weakify(self);
    [[self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [[self.completeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.currentDealImageView.highlighted) {
            [self.vm.dealOrderCommand execute:nil];
        } else {
            if (!self.vm.appointTime.length) {
                [DKProgressHUD showErrorWithStatus:@"请选择预约时间"];
                return;
            }
            [self.vm.appointOrderCommand execute:nil];
        }
    }];
}

@end
