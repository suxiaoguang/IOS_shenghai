//
//  DKNavigationController.m
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/10/18.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKNavigationController.h"

#import "DKTabBar.h"

@interface DKNavigationController () <UINavigationControllerDelegate>
@property (nonatomic,strong) id popDelegate;
@end

@implementation DKNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setShadowImage:[[UIImage alloc] init]];
    
    // 改变导航条的字体和背景颜色
    [bar setBarTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary *barTitleDic = [NSMutableDictionary dictionary];
    barTitleDic[NSForegroundColorAttributeName] = DKColorFontBlack;
    
    [bar setTitleTextAttributes:barTitleDic];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"ic_into_black"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"ic_into_black"] forState:UIControlStateHighlighted];
        backBtn.size = CGSizeMake(20, 20);
        // 让按钮内部的所有内容左对齐
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) { // 显示根控制器
        // 还原滑动返回手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    } else { // 不是显示根控制器
        // 实现滑动返回功能
        // 清空滑动返回手势的代理，就能实现滑动功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


@end
