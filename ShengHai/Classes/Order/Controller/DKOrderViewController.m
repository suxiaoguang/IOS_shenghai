//
//  DKOrderViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/16.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKOrderViewController.h"
#import "DKOrderListViewController.h"
#import "DKProfileNotificationViewController.h"
#import "DKOrderDetailViewController.h"

#import "DKNoticeBarButtonItemView.h"
#import "DKOrderRemindCountView.h"

#import "DKNoticeViewModel.h"
#import "HSUpdateApp.h"

@interface DKOrderViewController ()

@property (nonatomic, strong) DKNoticeViewModel *vm;

/** 未接单数量View1 */
@property (nonatomic, strong) DKOrderRemindCountView *countView1;
/** 未接单数量View2 */
@property (nonatomic, strong) DKOrderRemindCountView *countView2;
/** 未接单数量View3 */
@property (nonatomic, strong) DKOrderRemindCountView *countView3;

@end

@implementation DKOrderViewController
#pragma mark - setters && getters
- (DKNoticeViewModel *)vm
{
    if (!_vm) {
        _vm = [[DKNoticeViewModel alloc] init];
    }
    return _vm;
}

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self bind];
    [self setUpView];
    [self setUpAllViewController];
    [self setupNavItem];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self hsUpdateApp];
	});
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.vm.fetchNoticeUnreadCommand execute:nil];
	[self.vm.fetchOrderRemindCountCommand execute:nil];
}

-(void)hsUpdateApp{
	__weak __typeof(&*self)weakSelf = self;
	[HSUpdateApp hs_updateWithAPPID:@"1257595790" block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
		if (isUpdate == YES) {
			[weakSelf showStoreVersion:storeVersion openUrl:openUrl];
		}
	}];
}

-(void)showStoreVersion:(NSString *)storeVersion openUrl:(NSString *)openUrl{
	UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",storeVersion] preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSURL *url = [NSURL URLWithString:openUrl];
		[[UIApplication sharedApplication] openURL:url];
	}];
	UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		
	}];
	[alercConteoller addAction:actionYes];
	[alercConteoller addAction:actionNo];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alercConteoller animated:YES completion:nil];
}

- (void)setupNavItem
{
    DKNoticeBarButtonItemView *contentView = [DKNoticeBarButtonItemView messageNoticView];
    contentView.frame = CGRectMake(0, 0, 50, 50);
    @weakify(self);
    [[contentView rac_signalForSelector:@selector(noticeBtnClick)] subscribeNext:^(id x) {
        @strongify(self);
        DKProfileNotificationViewController *noticeVc = [[DKProfileNotificationViewController alloc] init];
        [self.navigationController pushViewController:noticeVc animated:YES];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

- (void)bind
{
    @weakify(self);
    [self.vm.fetchNoticeUnreadCommand.executionSignals.switchToLatest subscribeNext:^(NSString *x) {
        @strongify(self);
        DKNoticeBarButtonItemView *contentView = self.navigationItem.rightBarButtonItem.customView;
        contentView.smallRedView.hidden = x.integerValue > 0 ? NO : YES;
    }];
	
	[self.vm.fetchOrderRemindCountCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
		@strongify(self);
		self.countView1.countLabel.text = self.vm.orderRemindCount.count_wait;
		self.countView2.countLabel.text = self.vm.orderRemindCount.count_handle;
		self.countView3.countLabel.text = self.vm.orderRemindCount.count_pause;
		
		self.countView1.hidden = self.vm.orderRemindCount.count_wait.integerValue ? NO : YES;
		self.countView2.hidden = self.vm.orderRemindCount.count_handle.integerValue ? NO : YES;
		self.countView3.hidden = self.vm.orderRemindCount.count_pause.integerValue ? NO : YES;
	}];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:DKNoticeJumpNotification object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        NSDictionary *userInfo = x.object;
        NSString *orderId = userInfo[@"order_id"];
        NSString *messageType = userInfo[@"message_type"];
        if (DKToken) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                DKOrderDetailViewController *vc = [[DKOrderDetailViewController alloc] init];
                vc.orderId = orderId;
                if (![messageType isEqualToString:@"system"]) { // 系统消息
                    if ([messageType isEqualToString:@"order_new"]) { // 有新的订单
                        vc.orderType = DKOrderTypeWait;
                    } else if ([messageType isEqualToString:@"order_new_timeout"]) { // 接单超时
                        vc.orderType = DKOrderTypeWait;
                    } else if ([messageType isEqualToString:@"order_cancel"]) { // 用户取消了订单
                        vc.orderType = DKOrderTypeComplete;
                    } else if ([messageType isEqualToString:@"order_complete"]) { // 用户确认了订单
                        vc.orderType = DKOrderTypeComplete;
                    } else if ([messageType isEqualToString:@"order_appoint"]) { // 预约已到点
                        vc.orderType = DKOrderTypeDeal;
                    } else if ([messageType isEqualToString:@"order_handle_timeout"]) { // 处理订单超时
                        vc.orderType = DKOrderTypeDeal;
					} else if ([messageType isEqualToString:@"order_accept"]) { // 接单后得到的推送
						vc.orderType = DKOrderTypeDeal;
					} else if ([messageType isEqualToString:@"order_alert"]) { // 过了两个小时后得到的推送
						vc.orderType = DKOrderTypeDeal;
					}
                    [self.navigationController pushViewController:vc animated:YES];
				} else {
					DKProfileNotificationViewController *noticeVc = [[DKProfileNotificationViewController alloc] init];
					[self.navigationController pushViewController:noticeVc animated:YES];
				}
            });
        }
    }];
}
- (void)setUpView
{

    self.navigationItem.title = @"订单管理";
    self.isfullScreen = NO;

    [self setUpContentViewFrame:^(UIView *contentView) {
        CGFloat contentX = 0;
        CGFloat contentY = 64;
        CGFloat contentH = DKScreenH - contentY - 49;
        contentView.frame = CGRectMake(contentX, contentY, DKScreenW, contentH);
    }];

    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *titleFont = [UIFont systemFontOfSize:14];
        *norColor = DKColorFontDarkGray;
        *selColor = DKColorTintMain;
    }];

    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        *underLineColor = DKColorTintMain;
    }];
	
	CGFloat labelWidth = 43;
	CGFloat allLabelWidth = labelWidth * 5;
	CGFloat margin = (DKScreenW - allLabelWidth) / 6;
	CGFloat itemWidth = margin + labelWidth;
	CGFloat marginTop = 5;
	CGFloat viewWidthHeight = 16;
	
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(itemWidth, marginTop, viewWidthHeight, viewWidthHeight)];
	self.countView1 = [DKOrderRemindCountView loadView];
	self.countView1.frame = view.bounds;
	[view addSubview:self.countView1];
	[self.titleScrollView addSubview:view];
	
	UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(2 * itemWidth, marginTop, viewWidthHeight, viewWidthHeight)];
	self.countView2 = [DKOrderRemindCountView loadView];
	self.countView2.frame = view.bounds;
	[view1 addSubview:self.countView2];
	[self.titleScrollView addSubview:view1];
	
	UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(3 * itemWidth, marginTop, viewWidthHeight, viewWidthHeight)];
	self.countView3 = [DKOrderRemindCountView loadView];
	self.countView3.frame = view.bounds;
	[view2 addSubview:self.countView3];
	[self.titleScrollView addSubview:view2];
}

- (void)setUpAllViewController
{
    DKOrderListViewController *orderWaitVc = [[DKOrderListViewController alloc] init];
    orderWaitVc.title = @"未接单";
    orderWaitVc.orderType = DKOrderTypeWait;
    [self addChildViewController:orderWaitVc];

    DKOrderListViewController *orderDealVc = [[DKOrderListViewController alloc] init];
    orderDealVc.title = @"处理中";
    orderDealVc.orderType = DKOrderTypeDeal;
    [self addChildViewController:orderDealVc];

    DKOrderListViewController *orderHangVc = [[DKOrderListViewController alloc] init];
    orderHangVc.title = @"已挂起";
    orderHangVc.orderType = DKOrderTypeHang;
    [self addChildViewController:orderHangVc];

    DKOrderListViewController *orderTurnSendVc = [[DKOrderListViewController alloc] init];
    orderTurnSendVc.title = @"已转派";
    orderTurnSendVc.orderType = DKOrderTypeTurnSend;
    [self addChildViewController:orderTurnSendVc];

    DKOrderListViewController *orderCompleteVc = [[DKOrderListViewController alloc] init];
    orderCompleteVc.title = @"已完成";
    orderCompleteVc.orderType = DKOrderTypeComplete;
    [self addChildViewController:orderCompleteVc];
}

@end
