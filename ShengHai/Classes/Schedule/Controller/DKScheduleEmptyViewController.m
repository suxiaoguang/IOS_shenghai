//
//  DKScheduleEmptyViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/9.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKScheduleEmptyViewController.h"
#import "DKProfileNotificationViewController.h"

#import "DKNoticeBarButtonItemView.h"

#import "DKNoticeViewModel.h"

@interface DKScheduleEmptyViewController ()
@property (nonatomic, strong) DKNoticeViewModel *vm;
@end

@implementation DKScheduleEmptyViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKNoticeViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItem];
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"日程";
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.vm.fetchNoticeUnreadCommand execute:nil];
}

- (void)setupNavItem
{
    DKNoticeBarButtonItemView *contentView = [DKNoticeBarButtonItemView messageNoticView];
    contentView.frame = CGRectMake(0, 0, 50, 50);
    @weakify(self);
    [[contentView rac_signalForSelector:@selector(noticeBtnClick)] subscribeNext:^(id x) {
        @strongify(self);
        DKProfileNotificationViewController *noticeVc = [[DKProfileNotificationViewController alloc] init];
        [self.navigationController pushViewController:noticeVc animated:YES];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.fetchNoticeUnreadCommand.executionSignals.switchToLatest subscribeNext:^(NSString *x) {
        @strongify(self);
        DKNoticeBarButtonItemView *contentView = self.navigationItem.rightBarButtonItem.customView;
        contentView.smallRedView.hidden = x.integerValue > 0 ? NO : YES;
    }];
}

- (void)event
{
    
}

@end
