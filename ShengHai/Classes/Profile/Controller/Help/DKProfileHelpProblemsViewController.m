//
//  DKProfileHelpProblemsViewController.m
//  SF
//
//  Created by Arclin on 17/1/14.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileHelpProblemsViewController.h"
#import "Masonry.h"

@interface DKProfileHelpProblemsViewController ()

/** titles */
@property (nonatomic, strong) NSArray *titles;

/** Details */
@property (nonatomic, strong) NSArray *details;

@end

@implementation DKProfileHelpProblemsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"常见问题";

    self.dk_originArray = self.titles;
    self.dk_optionArray = self.details;

    // 初始化数据源
    self.dk_dataSorce = [NSMutableArray arrayWithArray:self.dk_originArray];
    self.tableView.backgroundColor = DKColorLineLightGray;
}

#pragma mark - setter & getter
- (NSArray *)titles
{
    if (!_titles) {
        _titles =
            @[@"预约修改及取消", @"预约无响应", @"完成订单"];
    }

    return _titles;
}

- (NSArray *)details
{
    if (!_details) {
        _details = @[
            @[@"预约修改及取消1"],
            @[@"预约无响应2"],
            @[@"完成订单3"]

        ];
    }

    return _details;
}

@end
