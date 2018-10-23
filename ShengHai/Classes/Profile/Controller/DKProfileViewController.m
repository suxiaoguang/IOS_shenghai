//
//  DKProfileViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/16.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileViewController.h"
#import "DKProfileWorkAlertViewController.h"
#import "DKProfileUserInfoViewController.h"
#import "DKProfileGradeViewController.h"

#import "DKProfileUserInfoViewModel.h"

#import "DKProfileStarInfo.h"

#import "DKProfileCell.h"

#define DKTableViewEdgeInset UIEdgeInsetsMake(0, 15, 0, 15)

@interface DKProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel        *nameLabel;                         // 姓名
@property (weak, nonatomic) IBOutlet UIView         *intoView;                          // 进入个人信息view
@property (weak, nonatomic) IBOutlet UIView         *gradeView;                         // 评价
@property (weak, nonatomic) IBOutlet UIImageView    *headImageView;                     // 头像

@property (weak, nonatomic) IBOutlet UILabel *gradeNumberLabel; // 评价分数Label
@property (weak, nonatomic) IBOutlet UIView *gradeRemindView; // 提醒小黄点

@property (weak, nonatomic) IBOutlet UILabel    *monthOrderLabel;                       // 月接单
@property (weak, nonatomic) IBOutlet UILabel    *monthCompleteLabel;                    // 月完成
@property (weak, nonatomic) IBOutlet UILabel    *weekOrderLabel;                        // 周接单
@property (weak, nonatomic) IBOutlet UILabel    *weekCompleteLabel;                     // 月完成
@property (weak, nonatomic) IBOutlet UILabel    *allOrderLabel;							// 总订单数
@property (weak, nonatomic) IBOutlet UILabel    *dealLabel;								// 解决率
@property (weak, nonatomic) IBOutlet UILabel    *responseLabel;							// 响应率
@property (weak, nonatomic) IBOutlet UILabel    *agreeLabel;							// 满意率

@property (weak, nonatomic) IBOutlet UITableView    *profileTableView;                  // tableView
@property (weak, nonatomic) IBOutlet UIImageView    *workStatusImageView;               // 工作状态图片

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer   *workStatusTap;         // 点击上班状态
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer   *userInfoTap;           // 点击用户信息
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer     *gradeTap;              // 点击评价

@property (nonatomic, strong) DKProfileWorkAlertViewController  *profileWorkAlertVc;    // 上下班alart
@property (nonatomic, strong) DKProfileUserInfoViewModel                *vm;                    // vm

@end

@implementation DKProfileViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKProfileUserInfoViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setUpView];
    [self event];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.vm.fetchOrderNumber execute:nil];
    [self.vm.fetchAccountScoreCommand execute:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setUpView
{
    self.fd_prefersNavigationBarHidden = YES;
    self.workStatusImageView.highlighted = [DKGetUserDefault(@"isWorking") isEqualToString:@"0"] ? NO : YES;
    [self loadBaseInfo];
}

- (void)loadBaseInfo
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:DKUserInfoCache.headimgurl] placeholderImage:[UIImage imageNamed:@"ic_user"]];
        self.nameLabel.text = DKUserInfoCache.staff_name;
    });
}

- (void)setupTableView
{
    [super setupTableView];
    self.tableView.sectionFooterHeight = 0;
    self.tableView.rowHeight = 40;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:DKUserInfoDidUpdatedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self loadBaseInfo];
    }];
    
    [self.vm.fetchOrderNumber.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.monthOrderLabel.text = self.vm.orderNumber.month_accept;
        self.monthCompleteLabel.text = self.vm.orderNumber.month_complete_percentage;
        self.weekOrderLabel.text = self.vm.orderNumber.week_accept;
        self.weekCompleteLabel.text = self.vm.orderNumber.week_complete_percentage;
		self.allOrderLabel.text = self.vm.orderNumber.total_order;
		self.dealLabel.text = self.vm.orderNumber.complete_percentage;
		self.responseLabel.text = self.vm.orderNumber.accept_percentage;
		self.agreeLabel.text = self.vm.orderNumber.comment_good_percentage;
    }];
	
    [self.vm.fetchAccountScoreCommand.executionSignals.switchToLatest subscribeNext:^(DKProfileStarInfo *x) {
        @strongify(self);
        self.gradeNumberLabel.text = [NSString dk_stringWithFormat:@"%.1f",x.star.floatValue];
        self.gradeRemindView.hidden = x.unread.integerValue > 0 ? NO : YES;
    }];
}

- (void)event
{
    @weakify(self);
    [self.workStatusTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        self.profileWorkAlertVc = [[DKProfileWorkAlertViewController alloc] init];
        self.profileWorkAlertVc.workBlock = ^(BOOL isWork) {
            @strongify(self);
            self.workStatusImageView.highlighted = isWork;
            self.tabBarController.tabBar.items[2].badgeValue = isWork ? @"" : @"未上班";
        };
        self.profileWorkAlertVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.profileWorkAlertVc.type = self.workStatusImageView.highlighted ? @"下班" : @"上班";
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.profileWorkAlertVc animated:NO completion:nil];
    }];

    [self.gradeTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        DKProfileGradeViewController *vc = [[DKProfileGradeViewController alloc] init];
        vc.starInfo = self.vm.starInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.userInfoTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        DKProfileUserInfoViewController *vc = [[DKProfileUserInfoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vm.viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DKProfileCell cellWithTableView:tableView indexPath:indexPath viewModel:self.vm];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = self.vm.viewControllers[indexPath.row];
    if (name.length) {
//        if ([name isEqualToString:@"DKProfileHelpViewController"]) {
//            [DKProgressHUD showInfoWithStatus:@"此功能暂未开放"];
//            return;
//        }
        Class   clazz = NSClassFromString(name);
        id      target = [[clazz alloc] init];
        [self.navigationController pushViewController:target animated:YES];
    }
}

// 分割线设间距
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:DKTableViewEdgeInset];
    }

    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:DKTableViewEdgeInset];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:DKTableViewEdgeInset];
    }

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:DKTableViewEdgeInset];
    }
}

@end
