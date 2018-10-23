//
//  DKTabBarController.m
//  YouYunBao
//
//  Created by 庄槟豪 on 16/5/10.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "DKTabBarController.h"
#import "DKNavigationController.h"

#import "DKOrderViewController.h"
#import "DKScheduleViewController.h"
#import "DKProfileViewController.h"
#import "DKScheduleEmptyViewController.h"

#import "DKTabBar.h"

@interface DKTabBarController ()<DKTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) DKProfileViewController *profileVc;

@end

@implementation DKTabBarController
#pragma mark - setters && getters
- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置所有的子控制器
    [self setupAllChildViewController];
    [self setupTabBar];
    
}

- (void)setupTabBar
{
    // 自定义tabBar
    DKTabBar *tabBar = [[DKTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    // 设置代理
    tabBar.delegate = self;
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    // 移除系统的tabBar
    [self.tabBar addSubview:tabBar];
}

/** 设置所有的子控制器 */
- (void)setupAllChildViewController
{
    // 订单
    DKOrderViewController *orderVc = [[DKOrderViewController alloc] init];
    [self setupOneViewController:orderVc title:@"订单" imageName:@"nav_order_normal" selectedImageName:@"nav_order_pressed"];
    
    // 日程
    DKScheduleViewController *scheduleVc = [[DKScheduleViewController alloc] init]; // 日历
//    DKScheduleEmptyViewController *scheduleVc = [[DKScheduleEmptyViewController alloc] init]; // 空界面
    [self setupOneViewController:scheduleVc title:@"日程" imageName:@"nav_schedule_normal" selectedImageName:@"nav_schedule_pressed"];
    
    // 我的
    self.profileVc = [[DKProfileViewController alloc] init];
    [self setupOneViewController:self.profileVc title:@"我的" imageName:@"nav_engineer_normal" selectedImageName:@"nav_engineer_pressed"];
}

/** 设置一个子控制器 */
- (void)setupOneViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectImageName
{
    vc.title = title;
    vc.tabBarItem.image = imageName.length ? [UIImage imageNamed:imageName] : nil;
    vc.tabBarItem.selectedImage = selectImageName.length ? [UIImage imageNamed:selectImageName] : nil;
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    DKNavigationController *navigationController = [[DKNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navigationController];
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(DKTabBar *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
}

@end
