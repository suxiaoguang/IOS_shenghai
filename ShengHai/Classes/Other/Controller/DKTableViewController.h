//
//  DKTableViewController.h
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/11/18.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKViewModel.h"

#define DKRegisterViewModel(vm, Class) \
- (DKViewModel *)viewModel \
{ \
    return self.vm; \
} \
\
- (Class *)vm \
{ \
    if (!_vm) { \
        _vm = [[Class alloc] init]; \
    } \
    return _vm; \
}

@interface DKTableViewController : UITableViewController

/** 是否开启分页 */
@property (nonatomic, assign, getter=isPagingEnabled) BOOL pagingEnabled;

/** 是否添加空界面 */
@property (nonatomic, assign, getter=isNeedNoDataView) BOOL needNoDataView;

/** viewModel */
- (DKViewModel *)viewModel;

/** TableView Config */
- (void)setupTableView;

/** 设置绑定数据 */
- (void)bind;

/** 高聚合RAC事件 */
- (void)events;

@end
