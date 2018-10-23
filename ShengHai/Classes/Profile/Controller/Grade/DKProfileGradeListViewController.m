//
//  DKProfileGradeListViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileGradeListViewController.h"
#import "DKProfileGradeDetailViewController.h"

#import "DKGradeViewModel.h"

#import "DKProfileGradeCell.h"

@interface DKProfileGradeListViewController ()
@property (nonatomic, strong) DKGradeViewModel *vm; // vm
@end

@implementation DKProfileGradeListViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKGradeViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pagingEnabled = YES;
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [RACObserve(self.vm, starInfoDetails) subscribeNext:^(id x) {
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
    return self.vm.starInfoDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKProfileGradeCell *cell = [DKProfileGradeCell cellWithTabelView:tableView indexPath:indexPath];
    cell.starInfoDetail = self.vm.starInfoDetails[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKProfileGradeDetailViewController *vc = [[DKProfileGradeDetailViewController alloc] init];
    vc.orderId = self.vm.starInfoDetails[indexPath.row].order_id;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
