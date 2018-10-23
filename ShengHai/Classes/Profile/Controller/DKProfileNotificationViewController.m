//
//  DKProfileNotificationViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/25.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileNotificationViewController.h"

#import "DKProfileNotificationCell.h"

#import "DKNoticeViewModel.h"

@interface DKProfileNotificationViewController ()
@property (nonatomic, strong) DKNoticeViewModel *vm;
@end

@implementation DKProfileNotificationViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKNoticeViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"消息通知";
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.pagingEnabled = YES;
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [RACObserve(self.vm, notices) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)event
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vm.notices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKProfileNotificationCell *cell = [DKProfileNotificationCell cellWithTabelView:tableView indexPath:indexPath];
    cell.notice = self.vm.notices[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDalegate

@end
