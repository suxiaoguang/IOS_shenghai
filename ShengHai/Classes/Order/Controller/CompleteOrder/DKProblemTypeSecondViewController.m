//
//  DKProblemTypeSecondViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProblemTypeSecondViewController.h"

#import "DKProblemTypeThirdViewController.h"

#import "DKDealWayCell.h"

#define DKSecondWikis self.orderWikis[self.parentRow].child

@interface DKProblemTypeSecondViewController ()

@end

@implementation DKProblemTypeSecondViewController
#pragma mark - setters && getters


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = self.navgationTitle;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 70;
}

- (void)dealloc
{
	DKLog(@"DKProblemTypeSecondViewController");
}

#pragma mark - events

- (void)event
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DKSecondWikis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKDealWayCell *cell = [DKDealWayCell cellWithTabelView:tableView indexPath:indexPath];
    cell.orderWikiSecond = DKSecondWikis[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDalegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.isShare) {
		self.callBackBlock([NSString dk_stringWithFormat:@"%@-%@",self.navgationTitle,DKSecondWikis[indexPath.row].text],
						   nil,
						   DKSecondWikis[indexPath.row].Id,
						   nil);
		[self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
	} else {
		DKProblemTypeThirdViewController *vc = [[DKProblemTypeThirdViewController alloc] init];
		vc.twoTitle = [NSString dk_stringWithFormat:@"%@-%@",self.navgationTitle,DKSecondWikis[indexPath.row].text];
		vc.secondWikiId = DKSecondWikis[indexPath.row].Id;
		vc.callBackBlock = self.callBackBlock;
		vc.orderWikiThird = DKSecondWikis[indexPath.row].child;
		vc.navgationTitle = DKSecondWikis[indexPath.row].text;
		vc.orderWikis = self.orderWikis;
		vc.parentRow = self.parentRow;
		vc.childRow = indexPath.row;
		[self.navigationController pushViewController:vc animated:YES];
	}
}

@end
