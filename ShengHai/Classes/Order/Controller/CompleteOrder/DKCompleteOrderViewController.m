//
//  DKCompleteOrderViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKCompleteOrderViewController.h"

#import "DKDealWayViewController.h"
#import "DKDealEventViewController.h"
#import "DKProblemTypeViewController.h"

#import "DKOrderDetailViewModel.h"

@interface DKCompleteOrderViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userCompanyTextField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIButton *wayButton;
@property (weak, nonatomic) IBOutlet UIButton *eventButton;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *wayLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic, strong) DKOrderDetailViewModel *vm; // vm

@end

@implementation DKCompleteOrderViewController
static NSString * const kPlanHolderText = @"请填写解决方案";

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
    self.navigationItem.title = @"添加维修记录";
    
    self.textView.delegate = self;
    self.textView.text = kPlanHolderText;
    self.textView.textColor = [UIColor lightGrayColor];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.completeOrderCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.callBackBlock(YES);
        [self.navigationController popViewControllerAnimated:YES];
        [DKProgressHUD showSuccessWithStatus:@"完成订单成功"];
    }];
}

- (void)event
{
    @weakify(self);
    // 问题类型
    [[self.typeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        DKProblemTypeViewController *vc = [[DKProblemTypeViewController alloc] init];
        vc.callBackBlock = ^(NSString *callBackType, NSString *callBackText, NSString *weakId, NSString *questType) {
            @strongify(self);
            self.typeLabel.text = callBackType;
            self.vm.weakId = weakId;
            self.vm.questType = questType;
            if (callBackText.length) {
                self.textView.text = callBackText;
                self.vm.fixPlan = callBackText;
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    // 解决方式
    [[self.wayButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        DKDealWayViewController *vc = [[DKDealWayViewController alloc] init];
        vc.callBackBlock = ^(NSString *callBackNumber, NSString *callBackText) {
            self.vm.solutionType = callBackNumber;
            self.wayLabel.text = callBackText;
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    // 解决情况
    [[self.eventButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        DKDealEventViewController *vc = [[DKDealEventViewController alloc] init];
        vc.callBackBlock = ^(NSString *callBackNumber, NSString *callBackText) {
            self.vm.solutionResult = callBackNumber;
            self.eventLabel.text = callBackText;
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    // 提交
    [[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
		if (!self.userCompanyTextField.text.length) {
			[DKProgressHUD showErrorWithStatus:@"请填写客户单位名称"];
			return;
		}
        if (!self.vm.questType.length) {
            [DKProgressHUD showErrorWithStatus:@"请选择问题类型"];
            return;
        }
        self.vm.fixPlan = self.textView.text;
		self.vm.user_company = self.userCompanyTextField.text;
        [self.vm.completeOrderCommand execute:nil];
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
