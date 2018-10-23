//
//  DKProfileAdressBookDetailViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileAdressBookDetailViewController.h"

#import "DKProfileUserInfoViewModel.h"

#import "DKProfileAddressBookDetailCell.h"

@interface DKProfileAdressBookDetailViewController ()

@property (nonatomic, strong) DKProfileUserInfoViewModel *vm;

@end

@implementation DKProfileAdressBookDetailViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKProfileUserInfoViewModel)

- (void)setMainArea:(NSString *)mainArea
{
	_mainArea = mainArea;
	self.vm.mainArea = mainArea;
}

- (void)setSubArea:(NSString *)subArea
{
	_subArea = subArea;
	self.vm.subArea = subArea;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"通讯录";
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
	[self.vm.fetchContactPeopleList.executing subscribeNext:^(id x) {
		@strongify(self);
		if ([x boolValue]) {
			[DKProgressHUD showLoadingToView:self.view];
		} else {
			[DKProgressHUD dismissForView:self.view];
		}
	}];
	
    [self.vm.fetchContactPeopleList.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)event
{
    [self.vm.fetchContactPeopleList execute:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vm.staffContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKProfileAddressBookDetailCell *cell = [DKProfileAddressBookDetailCell cellWithTabelView:tableView indexPath:indexPath];
    cell.staffContacts = self.vm.staffContacts[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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

@end
