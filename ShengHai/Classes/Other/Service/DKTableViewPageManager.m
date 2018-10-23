//
//  DKTableViewPageManager.m
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/12/9.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKTableViewPageManager.h"
#import "DKTableNoDataView.h"

@interface DKTableViewPageManager ()
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) DKViewModel *vm;
@property (nonatomic, strong) DKTableNoDataView *noDataView;
@end

@implementation DKTableViewPageManager

- (void)setPagingEnabled:(BOOL)pagingEnabled
{
    _pagingEnabled = pagingEnabled;
    
    RACCommand *loadDataCommand = self.vm.loadDataCommand;
    
    if (loadDataCommand) {
        @weakify(self);
        self.tableView.mj_header = [DKRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.page = 1;
            [self.tableView.mj_footer endRefreshing];
            [loadDataCommand execute:@(self.page)];
        }];
        
        if (self.isPagingEnabled) {
            self.tableView.mj_footer = [DKRefreshFooter footerWithRefreshingBlock:^{
                @strongify(self);
                [self.tableView.mj_header endRefreshing];
                [loadDataCommand execute:@(self.page)];
            }];
        }
        
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)setVm:(DKViewModel *)vm
{
    _vm = vm;
    
    @weakify(self);
    [self.vm.loadDataCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if (![x boolValue]) {
            self.page++;
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
    [self.vm.noMoreSubject subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            });
        });
    }];
    
    [self.vm.loadDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *dataSources) {
        @strongify(self);
        if (self.page == 1 && [dataSources isKindOfClass:[NSArray class]]) {
            if (dataSources.count) {
                [self removeNoDataView];
            } else {
                [self addNoDataView];
            }
        }
    }];
}

- (instancetype)initWithTableView:(UITableView *)tableView viewModel:(DKViewModel *)viewModel
{
    self.tableView = tableView;
    self.vm = viewModel;
    
    return self;
}

#pragma mark - Private

- (void)addNoDataView
{
    if (!self.noDataView && self.isNeedNoDataView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            DKTableNoDataView *noDataView = [DKTableNoDataView noDataView];
            noDataView.frame = self.tableView.frame;
            self.noDataView = noDataView;
            [self.tableView addSubview:noDataView];
        });
    }
}

- (void)removeNoDataView
{
    if (self.noDataView) {
        [self.noDataView removeFromSuperview];
        self.noDataView = nil;
    }
}

@end
