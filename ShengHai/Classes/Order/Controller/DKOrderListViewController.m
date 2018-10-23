//
//  DKOrderListViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderListViewController.h"
#import "DKOrderDetailViewController.h"

#import "DKOrderViewModel.h"
#import "DKOrderList.h"

#import "DKOrderCell.h"

@interface DKOrderListViewController ()

@property (nonatomic, strong) DKOrderViewModel *vm;

@end

@implementation DKOrderListViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKOrderViewModel)

- (void)setOrderType:(DKOrderType)orderType
{
    _orderType = orderType;
    self.vm.orderType = orderType;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView.mj_header beginRefreshing];
    });
    
    [self.vm.fetchWorkStatusCommand execute:nil];
}

- (void)setUpView
{
    self.tableView.estimatedRowHeight = 160;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pagingEnabled = YES;
}

#pragma mark - events
- (void)bind
{
    [super bind];
    
    @weakify(self);
    [RACObserve(self.vm, orderList) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [self.vm.fetchWorkStatusCommand.executionSignals.switchToLatest subscribeNext:^(NSString *isWorking) {
        @strongify(self);
        self.tabBarController.tabBar.items[2].badgeValue = [isWorking isEqualToString:@"1"] ? @"" : @"未上班";
        DKSetUserDefault(@"isWorking", isWorking);
    }];
}

- (void)event
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vm.orderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKOrderCell *cell = [DKOrderCell cellWithTabelView:tableView indexPath:indexPath];
    cell.orderType = self.orderType;
    cell.orderList = self.vm.orderList[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDalegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.orderType != DKOrderTypeTurnSend) {
        DKOrderDetailViewController *vc = [[DKOrderDetailViewController alloc] init];
        vc.orderType = self.orderType;
        vc.orderId = self.vm.orderList[indexPath.row].order_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
