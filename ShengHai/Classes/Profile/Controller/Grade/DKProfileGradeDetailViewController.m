//
//  DKProfileGradeDetailViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/25.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileGradeDetailViewController.h"
#import "DKProfileEvaluateView.h"
#import "DKGradeViewModel.h"
#import "DKStarInfoDetail.h"

@interface DKProfileGradeDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *topBackgroundView;     // 顶部阴影
@property (weak, nonatomic) IBOutlet UIView *agingGradeAddView;     // 时效
@property (weak, nonatomic) IBOutlet UIView *attitudeGradeAddView;  // 态度
@property (weak, nonatomic) IBOutlet UIView *qualityGradeAddView;   // 质量

@property (weak, nonatomic) IBOutlet UIView *bottomBackgroundView;  // 底部阴影
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) DKProfileEvaluateView *agingGradeView;
@property (nonatomic, strong) DKProfileEvaluateView *attitudeGradeView;
@property (nonatomic, strong) DKProfileEvaluateView *qualityGradeView;

@property (nonatomic, strong) DKGradeViewModel *vm;

@end

@implementation DKProfileGradeDetailViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKGradeViewModel)

- (void)setOrderId:(NSString *)orderId
{
    _orderId = orderId;
    self.vm.orderId = orderId;
}

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setUpView];
    [self event];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    [self.textView setContentOffset:CGPointZero animated:NO];
}

- (void)setUpView
{
    self.navigationItem.title = @"评价详情";

    [self.topBackgroundView dk_addShadowToView];
    [self.bottomBackgroundView dk_addShadowToView];
    
    // 时效
    self.agingGradeView = [DKProfileEvaluateView evaluateView];
    [self.agingGradeAddView addSubview:self.agingGradeView];
    
    // 态度
    self.attitudeGradeView = [DKProfileEvaluateView evaluateView];
    [self.attitudeGradeAddView addSubview:self.attitudeGradeView];
    
    // 质量
    self.qualityGradeView = [DKProfileEvaluateView evaluateView];
    [self.qualityGradeAddView addSubview:self.qualityGradeView];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.fetchStarInfoDetailCommand.executionSignals.switchToLatest subscribeNext:^(DKStarInfoDetail *x) {
        @strongify(self);
        self.agingGradeView.index = x.comment_star_1.integerValue;
        self.attitudeGradeView.index = x.comment_star_2.integerValue;
        self.qualityGradeView.index = x.comment_star_3.integerValue;
        self.textView.text = x.comment_text;
    }];
}

- (void)event
{
    [self.vm.fetchStarInfoDetailCommand execute:nil];
}

@end
