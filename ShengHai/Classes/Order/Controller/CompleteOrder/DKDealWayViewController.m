//
//  DKDealWayViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKDealWayViewController.h"

#import "DKDealWayCell.h"

@interface DKDealWayViewController ()
@property (nonatomic, strong) NSArray *dataSources;
@end

@implementation DKDealWayViewController
#pragma mark - setters && getters


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"解决方式";
}

#pragma mark - events
- (void)bind
{
	[super bind];
    self.dataSources = @[@"远程",
                         @"电话",
                         @"现场"
                         ];
}

- (void)event
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKDealWayCell *cell = [DKDealWayCell cellWithTabelView:tableView indexPath:indexPath dataSources:self.dataSources];
    return cell;
}

#pragma mark - UITableViewDalegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.callBackBlock([NSString dk_stringWithFormat:@"%ld",(long)indexPath.row],self.dataSources[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
