//
//  DKTableViewPageManager.h
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/12/9.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKTableViewPageManager : NSObject

/** 是否开启分页 */
@property (nonatomic, assign, getter=isPagingEnabled) BOOL pagingEnabled;

/** 是否添加空界面 */
@property (nonatomic, assign, getter=isNeedNoDataView) BOOL needNoDataView;

- (instancetype)initWithTableView:(UITableView *)tableView viewModel:(DKViewModel *)viewModel;

@end
