//
//  DKProfileGradeViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/23.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileGradeViewController.h"
#import "DKProfileGradeListViewController.h"

#import "DKProfileEvaluateView.h"
#import "DKProfileGradeCell.h"

@interface DKProfileGradeViewController ()

@property (weak, nonatomic) IBOutlet UIView *evaluateAddView;
@property (nonatomic, strong) DKProfileEvaluateView *profileEvaluateView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *gradeNumberLabel;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *backTap;

@property (weak, nonatomic) IBOutlet UIView *addView;

@end

@implementation DKProfileGradeViewController
#pragma mark - setters && getters


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:DKUserInfoCache.headimgurl] placeholderImage:[UIImage imageNamed:@"ic_user"]];
    self.gradeNumberLabel.text = [NSString dk_stringWithFormat:@"用户评价 %.1f",self.starInfo.star.floatValue];
    
    // 添加星级评价View
    self.profileEvaluateView = [DKProfileEvaluateView evaluateView];
    self.profileEvaluateView.index = self.starInfo.star.integerValue;
    [self.evaluateAddView addSubview:self.profileEvaluateView];
    
    DKProfileGradeListViewController *vc = [[DKProfileGradeListViewController alloc] init];
    vc.view.frame = self.addView.bounds;
    [self addChildViewController:vc];
    [self.addView addSubview:vc.view];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:DKUserInfoDidUpdatedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:DKUserInfoCache.headimgurl] placeholderImage:[UIImage imageNamed:@"ic_user"]];
    }];
}

- (void)event
{
    @weakify(self);
    [self.backTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
