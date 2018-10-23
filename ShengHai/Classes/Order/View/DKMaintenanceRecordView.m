//
//  DKMaintenanceRecordView.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/4.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKMaintenanceRecordView.h"
#import "DKMaintenanceRecordCell.h"

@interface DKMaintenanceRecordView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DKMaintenanceRecordView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.order.record.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKMaintenanceRecordCell *cell = [DKMaintenanceRecordCell cellWithTabelView:tableView indexPath:indexPath];
    cell.orderRecord = self.order.record[indexPath.row];
    return cell;
}

@end
