//
//  DKTabBar.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/16.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKTabBar.h"

#import "DKTabBarButton.h"

@interface DKTabBar ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation DKTabBar
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // 遍历模型数组，创建对应tabBarButton
    for (UITabBarItem *item in _items) {
        
        DKTabBarButton *btn = [DKTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) { // 选中第0个
            [self btnClick:btn];
        }
        
        [self addSubview:btn];
        
        // 把按钮添加到按钮数组
        [self.buttons addObject:btn];
    }
}

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

// self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, w, 1);
    view.backgroundColor = DKColorLineGray;
    [self addSubview:view];
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / self.items.count;
    CGFloat btnH = self.bounds.size.height;
    
    int i = 0;
    // 设置tabBarButton的frame
    for (UIView *tabBarButton in self.buttons) {
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
}

@end
