//
//  DKDealEventViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKDealEventViewController.h"

#import "DKDealWayCell.h"

@interface DKDealEventViewController ()
@property (nonatomic, strong) NSArray *dataSources;
@end

@implementation DKDealEventViewController
#pragma mark - setters && getters


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"解决情况";
}

#pragma mark - events
- (void)bind
{
	[super bind];
    self.dataSources = @[@"完全解决",
                         @"变通解决",
                         @"故障自动恢复",
                         @"重大事件关闭",
                         @"故障由用户自行解决",
                         @"用户放弃解决",
                         @"超出服务范围",
                         @"无法解决",
                         @"转其他通道"
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
