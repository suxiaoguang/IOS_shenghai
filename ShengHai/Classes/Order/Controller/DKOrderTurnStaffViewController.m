//
//  DKOrderTurnStaffViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderTurnStaffViewController.h"

#import "DKOrderDetailViewModel.h"

#import "DKOrderTurnStaffCell.h"

#import "DKOrderStaff.h"

@interface DKOrderTurnStaffViewController ()
@property (nonatomic, strong) DKOrderDetailViewModel *vm;
@end

@implementation DKOrderTurnStaffViewController
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
    self.navigationItem.title = @"订单转派";
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.fetchStaffListCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [self.vm.turnOrderCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popToRootViewControllerAnimated:YES];
        [DKProgressHUD showSuccessWithStatus:@"转派成功"];
    }];
}

- (void)event
{
    [self.vm.fetchStaffListCommand execute:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vm.orderStaffs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKOrderTurnStaffCell *cell = [DKOrderTurnStaffCell cellWithTabelView:tableView indexPath:indexPath];
    cell.orderStaff = self.vm.orderStaffs[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDalegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    [UIAlertController dk_alertWithOKCancelBtnWithTitle:@"转派" message:[NSString dk_stringWithFormat:@"是否确认转派给工程师'%@'",self.vm.orderStaffs[indexPath.row].staff_name] clickBtnAtIndex:^(NSInteger index) {
        @strongify(self);
        self.vm.staffId = self.vm.orderStaffs[indexPath.row].staff_id;
        [self.vm.turnOrderCommand execute:nil];
    }];
}

@end
