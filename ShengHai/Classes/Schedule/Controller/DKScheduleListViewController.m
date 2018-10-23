//
//  DKScheduleListViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKScheduleListViewController.h"
#import "DKOrderDetailViewController.h"

#import "DKScheduleCell.h"

#import "DKScheduleViewModel.h"
#import "DKDayCalendar.h"

@interface DKScheduleListViewController ()

@property (nonatomic, strong) DKScheduleViewModel *vm; // vm

@end

@implementation DKScheduleListViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKScheduleViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = self.dateTitle;
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.fetchScheduleListCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue] == YES) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
    }];
    
    [RACObserve(self.vm, monthCalendars) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)event
{
    self.vm.param.year = [self.date dk_dateStrWithFormat:@"yyyy"];
    self.vm.param.month = [self.date dk_dateStrWithFormat:@"MM"];
    self.vm.param.day = [self.date dk_dateStrWithFormat:@"dd"];
    [self.vm.fetchScheduleListCommand execute:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vm.monthCalendars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKScheduleCell *cell = [DKScheduleCell cellWithTabelView:tableView indexPath:indexPath];
    cell.dayCalendar = self.vm.monthCalendars[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDalegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKOrderDetailViewController *vc = [[DKOrderDetailViewController alloc] init];
    vc.orderId = self.vm.monthCalendars[indexPath.row].order_id;
    vc.orderType = DKOrderTypeDeal;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
