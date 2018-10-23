//
//  DKProblemTypeViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProblemTypeViewController.h"

#import "DKProblemTypeSecondViewController.h"

#import "DKProblemTypeCell.h"

#import "DKOrderDetailViewModel.h"

@interface DKProblemTypeViewController ()

@property (nonatomic, strong) DKOrderDetailViewModel *vm;  // vm

@end

@implementation DKProblemTypeViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKOrderDetailViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"选择问题类型";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 70;
}

- (void)dealloc
{
	DKLog(@"DKProblemTypeViewController");
}

#pragma mark - events
- (void)bind
{
	[super bind];
    @weakify(self);
    [self.vm.fetchOrderWikiListCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
    }];
    
    [self.vm.fetchOrderWikiListCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)event
{
    [self.vm.fetchOrderWikiListCommand execute:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vm.orderWikis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKProblemTypeCell *cell = [DKProblemTypeCell cellWithTabelView:tableView indexPath:indexPath];
    cell.orderWikiFirst = self.vm.orderWikis[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKProblemTypeSecondViewController *vc = [[DKProblemTypeSecondViewController alloc] init];
	vc.isShare = self.isShare;
    vc.callBackBlock = self.callBackBlock;
    vc.orderWikis = self.vm.orderWikis;
    vc.parentRow = indexPath.row;
    vc.orderWikiSecond = self.vm.orderWikis[indexPath.row].child;
    vc.navgationTitle = self.vm.orderWikis[indexPath.row].text;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
