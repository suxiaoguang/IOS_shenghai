//
//  DKProfileShareKnowledgeViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileShareKnowledgeViewController.h"
#import "DKProfileSuccessAlertViewController.h"


#import "DKDealWayViewController.h"
#import "DKDealEventViewController.h"
#import "DKProblemTypeViewController.h"

#import "DKOrderDetailViewModel.h"

@interface DKProfileShareKnowledgeViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *typeButton;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic, strong) DKOrderDetailViewModel *vm; // vm

@end

@implementation DKProfileShareKnowledgeViewController
static NSString * const kPlanHolderText = @"请填写方案内容";

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
    self.navigationItem.title = @"分享知识";
    
    self.textView.delegate = self;
    self.textView.text = kPlanHolderText;
    self.textView.textColor = [UIColor lightGrayColor];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.shareKnowledgeCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
		DKProfileSuccessAlertViewController *vc = [[DKProfileSuccessAlertViewController alloc] init];
		vc.successText = @"提交成功, 后台审核通过后将在\n知识库里看到您的分享哦~";
		vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
		NZModalViewController(vc);
    }];
}

- (void)event
{
    @weakify(self);
    // 问题类型
    [[self.typeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        DKProblemTypeViewController *vc = [[DKProblemTypeViewController alloc] init];
		vc.isShare = YES;
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
	
    // 提交
    [[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (!self.vm.weakId.length) {
            [DKProgressHUD showErrorWithStatus:@"请选择问题类型"];
            return;
        }
		if (!self.textField.text.length) {
			[DKProgressHUD showErrorWithStatus:@"请填写方案名称"];
			return;
		}
		if ([self.textView.text isEqualToString:kPlanHolderText]) {
			[DKProgressHUD showErrorWithStatus:@"请填写方案内容"];
			return;
		}
		self.vm.questType = self.textField.text;
		self.vm.fixPlan = [self.textView.text isEqualToString:kPlanHolderText] ? @"" : self.textView.text;
        [self.vm.shareKnowledgeCommand execute:nil];
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
