//
//  DKViewController.m
//  ColdChain
//
//  Created by 庄槟豪 on 2016/10/24.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKViewController.h"

#import "DKTableViewPageManager.h"

@interface DKViewController ()
@property (nonatomic, strong) DKTableViewPageManager *pageManager;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DKViewController

#pragma mark - Getters && Setters

- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    _pagingEnabled = pagingEnabled;
    
    self.pageManager.pagingEnabled = pagingEnabled;
}

- (void)setNeedNoDataView:(BOOL)needNoDataView
{
    _needNoDataView = needNoDataView;
    
    self.pageManager.needNoDataView = needNoDataView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [self findTableView:self.view];
    }
    return _tableView;
}

- (DKTableViewPageManager *)pageManager
{
    if (!_pageManager) {
        _pageManager = [[DKTableViewPageManager alloc] initWithTableView:self.tableView viewModel:self.viewModel];
        _pageManager.pagingEnabled = NO;
        _pageManager.needNoDataView = YES;
    }
    return _pageManager;
}

- (DKViewModel *)viewModel
{
    return nil;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = DKColorLineLightGray;
    
    [self setupTableView];
    
    [self pageManager];
    
    [self dataBinding];
    
    [self events];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)setupTableView
{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = DKSmallMargin;
    self.tableView.backgroundColor = DKColorLineLightGray;
    
    if (self.tableView.style == UITableViewStyleGrouped) {
        self.tableView.contentInset = UIEdgeInsetsMake(-DKGroupTableViewInsetTop, 0, 0, 0);
    }
}

#pragma mark - Events

- (void)dataBinding
{
    @weakify(self);
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            DKLog(@"Commond Error in Vc:【%@】, Reason:【%@】",NSStringFromClass([self class]), error.localizedDescription);
            if (self.view.window == [UIApplication sharedApplication].keyWindow) {
                if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."] ||
                    [error.localizedDescription isEqualToString:@"The request timed out."]) {
                    [DKProgressHUD showErrorWithStatus:@"网络异常"];
                } else {
                    [DKProgressHUD showErrorWithStatus:error.localizedDescription];
                }
            }
        });
    }];
    
    [self bind];
}

- (void)bind {}

- (void)events {}

#pragma mark - <UITableViewDelegate>

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (UITableView *)findTableView:(UIView *)view
{
    UITableView *tableView = nil;
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UITableView class]]) {
            tableView = (UITableView *)subView;
            break;
        } else {
            tableView = [self findTableView:subView];
            if ([tableView isKindOfClass:[UITableView class]]) {
                break;
            }
        }
    }
    
    return tableView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = DKColorLineLightGray;
    
    return view;
}

@end
