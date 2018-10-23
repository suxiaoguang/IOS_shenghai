//
//  DKViewController.h
//  ColdChain
//
//  Created by 庄槟豪 on 2016/10/24.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKViewModel.h"

@interface DKViewController : UIViewController

/** 是否开启分页 */
@property (nonatomic, assign, getter=isPagingEnabled) BOOL pagingEnabled;

/** 是否添加空界面 */
@property (nonatomic, assign, getter=isNeedNoDataView) BOOL needNoDataView;

/** 需要分页的表格 */
- (UITableView *)tableView;

/** viewModel */
- (DKViewModel *)viewModel;

/** TableView Config */
- (void)setupTableView;

/** 设置绑定数据 */
- (void)bind;

/** 高聚合RAC事件 */
- (void)events;

@end
