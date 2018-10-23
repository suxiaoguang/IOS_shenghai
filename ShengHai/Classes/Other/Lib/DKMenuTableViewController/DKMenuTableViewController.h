//
//  DKTableViewController.h
//  DKTableViewMenu
//
//  Created by Arclin on 16/5/14.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKMenuTableViewController : UITableViewController

/**
 * 父选项数组
 */
@property (nonatomic,strong) NSArray *dk_originArray;

/**
 *  选项
 */
@property (nonatomic,strong) NSArray *dk_optionArray;

/**
 *  组标题
 */
@property (nonatomic,strong) NSArray *dk_sectionArray;

/**
 * 数据源
 */
@property (nonatomic,strong) NSMutableArray *dk_dataSorce;

/**
 * 右标题数据
 */
//@property (nonatomic,strong) NSArray *dk_detailArray;

/**
 * detailText的数据源
 */
//@property (nonatomic,strong) NSMutableArray *dk_detailTextDataSoure;

/**
 * 初始化展示所有选项
 */
- (void)showAllOption;

/**
 *  点击了选项
 */
- (void)tableView:(UITableView *)tableView didSelectOption:(NSIndexPath *)indexPath;

/**
 *  点击了父选项
 */
- (void)tableView:(UITableView *)tableView didSelectParentOption:(NSIndexPath *)indexPath;

@end
