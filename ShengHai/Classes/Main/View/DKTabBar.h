//
//  DKTabBar.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/16.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKTabBar;

@protocol DKTabBarDelegate <NSObject>

@optional
- (void)tabBar:(DKTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface DKTabBar : UIView

/** item数组 */
@property (nonatomic, strong) NSArray<UITabBarItem *> *items;

/** 协议 */
@property (nonatomic, weak) id<DKTabBarDelegate> delegate;

@end
