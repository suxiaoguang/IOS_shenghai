//
//  DKProfileAddressBookViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileAddressBookViewController.h"
#import "DKProfileAdressBookDetailViewController.h"
#import "DKSearchContactViewController.h"

#import "DKProfileUserInfoViewModel.h"
#import "DKContactArea.h"

#import "DKProfileAddressBookCell.h"

@interface DKProfileAddressBookViewController ()

@property (nonatomic, strong) DKProfileUserInfoViewModel *vm; // vm

@end

@implementation DKProfileAddressBookViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKProfileUserInfoViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"通讯录";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	@weakify(self);
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem dk_itemForButtonWithImage:[UIImage imageNamed:@"ic_search"] actionBlock:^(UIButton *button) {
		@strongify(self);
		DKSearchContactViewController *vc = [[DKSearchContactViewController alloc] init];
		[self.navigationController pushViewController:vc animated:YES];
	}];
}

#pragma mark - events
- (void)bind
{
	@weakify(self);
	[RACObserve(self.vm, contactAreas) subscribeNext:^(id x) {
		@strongify(self);
		[self.tableView reloadData];
	}];
}

- (void)event
{
	if (!self.contactArea.region_sub_list.count) {
		[self.vm.fetchContactArea execute:nil];
	}
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (!self.contactArea.region_sub_list.count) {
		return self.vm.contactAreas.count;
	} else {
		return self.contactArea.region_sub_list.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKProfileAddressBookCell *cell = [DKProfileAddressBookCell cellWithTabelView:tableView indexPath:indexPath];
	if (!self.contactArea.region_sub_list.count) {
		cell.titleLabel.text = self.vm.contactAreas[indexPath.row].region_main;
	} else {
		cell.titleLabel.text = self.contactArea.region_sub_list[indexPath.row];
	}
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (!self.contactArea.region_sub_list.count) {
		DKProfileAddressBookViewController *vc = [[DKProfileAddressBookViewController alloc] init];
		vc.contactArea = self.vm.contactAreas[indexPath.row];
		[self.navigationController pushViewController:vc animated:YES];
	} else {
		DKProfileAdressBookDetailViewController *vc = [[DKProfileAdressBookDetailViewController alloc] init];
		vc.mainArea = self.contactArea.region_main;
		vc.subArea = self.contactArea.region_sub_list[indexPath.row];
		[self.navigationController pushViewController:vc animated:YES];
	}
}

@end
