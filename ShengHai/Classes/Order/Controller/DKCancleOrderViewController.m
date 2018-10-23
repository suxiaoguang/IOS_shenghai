//
//  DKCancleOrderViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKCancleOrderViewController.h"

#import "DKOrderDetailViewModel.h"

@interface DKCancleOrderViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;

@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourImageView;

@property (nonatomic, strong) DKOrderDetailViewModel *vm;

@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end

@implementation DKCancleOrderViewController
static NSString * const kPlanHolderText = @"请填写补充说明";

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
    self.navigationItem.title = @"取消订单";
    self.textView.delegate = self;
    self.textView.text = kPlanHolderText;
    self.textView.textColor = [UIColor lightGrayColor];
}

- (IBAction)clickButton:(id)sender {
    if (sender == self.oneButton) {
        [self setUpImageHiddenWithOne:NO two:YES three:YES four:YES];
    } else if (sender == self.twoButton) {
        [self setUpImageHiddenWithOne:YES two:NO three:YES four:YES];
    } else if (sender == self.threeButton) {
        [self setUpImageHiddenWithOne:YES two:YES three:NO four:YES];
    } else {
        [self setUpImageHiddenWithOne:YES two:YES three:YES four:NO];
    }
}

#pragma mark - private
- (void)setUpImageHiddenWithOne:(BOOL)hiddenOne two:(BOOL)hiddenTwo three:(BOOL)hiddenThree four:(BOOL)hiddenFour
{
    self.oneImageView.hidden = hiddenOne;
    self.twoImageView.hidden = hiddenTwo;
    self.threeImageView.hidden = hiddenThree;
    self.fourImageView.hidden = hiddenFour;
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.cancelOrderCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.callBackBlock(YES);
        [self.navigationController popViewControllerAnimated:YES];
        [DKProgressHUD showSuccessWithStatus:@"取消订单成功"];
    }];
}

- (void)event
{
    @weakify(self);
    [[self.commitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (!self.oneImageView.hidden) {
            self.vm.canleReason = @"临时有事,下次再解决";
        } else if (!self.twoImageView.hidden) {
            self.vm.canleReason = @"订单重复提交";
        } else if (!self.threeImageView.hidden) {
            self.vm.canleReason = @"联系不上";
        } else {
            self.vm.canleReason = @"其它原因";
			if (self.textView.text.length && ![self.textView.text isEqualToString:kPlanHolderText]) {
				self.vm.canleReason = [NSString dk_stringWithFormat:@"%@,补充说明:%@",self.vm.canleReason,self.textView.text];
			} else {
				[DKProgressHUD showErrorWithStatus:@"请填写补充说明"];
				return;
			}
        }
        self.vm.isCanResume = self.twoImageView.hidden ? @"0" : @"1";
        [self.vm.cancelOrderCommand execute:nil];
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
