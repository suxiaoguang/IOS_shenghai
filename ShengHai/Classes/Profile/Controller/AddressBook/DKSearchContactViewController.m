//
//  DKSearchContactViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/27.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKSearchContactViewController.h"

#import "DKProfileUserInfoViewModel.h"

#import "DKProfileAddressBookDetailCell.h"
#import "DKTableNoDataView.h"

@interface DKSearchContactViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) DKProfileUserInfoViewModel *vm;

@property (nonatomic, strong) DKTableNoDataView *noDataView;

@end

@implementation DKSearchContactViewController
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
	self.view.backgroundColor = [UIColor whiteColor];
	self.fd_prefersNavigationBarHidden = YES;
}

#pragma mark - events
- (void)bind
{
	RAC(self.vm, keyword) = self.textField.rac_textSignal;
	
	@weakify(self);
	[self.vm.searchContactCommand.executing subscribeNext:^(id x) {
		if ([x boolValue]) {
			[DKProgressHUD showLoadingToView:self.view];
		} else {
			[DKProgressHUD dismissForView:self.view];
		}
	}];
	
	[self.vm.searchContactCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
		@strongify(self);
		[self.tableView reloadData];
		if (!self.vm.staffContacts.count) {
			DKTableNoDataView *noDataView = [DKTableNoDataView noDataView];
			noDataView.frame = self.tableView.bounds;
			self.noDataView = noDataView;
			[self.tableView addSubview:noDataView];
		} else {
			[self.noDataView removeFromSuperview];
			self.noDataView = nil;
		}
	}];
}

- (void)event
{
	@weakify(self);
	[[self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
		@strongify(self);
		[self.navigationController popViewControllerAnimated:YES];
	}];
	
	[[self.searchButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
		@strongify(self);
		[self.vm.searchContactCommand execute:nil];
	}];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.vm.staffContacts[indexPath.row].staff_phone];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
