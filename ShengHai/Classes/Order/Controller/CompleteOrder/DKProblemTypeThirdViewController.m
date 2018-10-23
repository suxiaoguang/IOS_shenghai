//
//  DKProblemTypeThirdViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProblemTypeThirdViewController.h"
#import "DKDealWayWikiViewController.h"

#import "DKDealWayCell.h"

#define DKThirdWikis self.orderWikis[self.parentRow].child[self.childRow].child

@interface DKProblemTypeThirdViewController ()

@end

@implementation DKProblemTypeThirdViewController
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
    
    if (!self.callBackBlock) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem dk_itemForButtonWithImage:[UIImage imageNamed:@"ic_add"] actionBlock:^(UIButton *button) {
            [UIAlertController dk_alertWithtPlainText:@"知识库" isSecure:NO message:@"知识库问题" placeholder:@"请输入知识库问题" keyBoardType:UIKeyboardTypeDefault clickBtnAtIndex:^(NSInteger index, NSString *text) {
                if (index && text.length) {
                    DKOrderWikiThird *wikiThird = [[DKOrderWikiThird alloc] init];
                    wikiThird.text = text;
                    [DKThirdWikis addObject:wikiThird];
                    DKSetCache(DKUserInfoCache.staff_id, self.orderWikis);
                    [DKProgressHUD showSuccessWithStatus:@"添加成功" toView:[UIApplication sharedApplication].keyWindow];
                    [self.tableView reloadData];
                } else if (index && !text.length) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [DKProgressHUD showErrorWithStatus:@"知识库问题不能为空" toView:[UIApplication sharedApplication].keyWindow];
                    });
                }
            }];
        }];
    }
}



#pragma mark - events
- (void)bind
{
    
}

- (void)event
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DKThirdWikis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKDealWayCell *cell = [DKDealWayCell cellWithTabelView:tableView indexPath:indexPath];
    cell.orderWikiThird = DKThirdWikis[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDalegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.callBackBlock) {
        self.callBackBlock([NSString dk_stringWithFormat:@"%@-%@",self.twoTitle,DKThirdWikis[indexPath.row].text],
                           DKThirdWikis[indexPath.row].fix_plan,
                           self.secondWikiId,
                           DKThirdWikis[indexPath.row].text);
        [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
    } else {
        DKDealWayWikiViewController *vc = [[DKDealWayWikiViewController alloc] init];
        vc.orderWikis = self.orderWikis;
        vc.childRow = self.childRow;
        vc.parentRow = self.parentRow;
        vc.grandsonRow = indexPath.row;
        vc.dealWayText = DKThirdWikis[indexPath.row].fix_plan;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
