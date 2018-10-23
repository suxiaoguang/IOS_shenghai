//
//  UITableView+DKExtension.m
//  DKExtension
//
//  Created by 庄槟豪 on 2016/12/9.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "UITableView+DKExtension.h"
#import <objc/runtime.h>

@implementation UITableView (DKExtension)

static char dk_dataSourceKey;

- (void)setDk_dataSource:(NSArray *)dk_dataSource
{
    objc_setAssociatedObject(self, &dk_dataSourceKey, dk_dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)dk_dataSource
{
    return objc_getAssociatedObject(self, &dk_dataSourceKey);
}

@end
