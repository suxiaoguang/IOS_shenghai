//
//  DKOrderDetailViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/26.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "DKOrderDetailViewController.h"
#import "DKOrderTurnStaffViewController.h"
#import "DKAccemptOrderViewController.h"
#import "DKPauseOrderViewController.h"
#import "DKCancleOrderViewController.h"
#import "DKCompleteOrderViewController.h"

#import "DKOrderDetailViewModel.h"
#import "EMVoiceConverter.h"
#import "MJPhotoBrowser.h"

#import "DKOrderStateView.h"
#import "DKOrderUserInfoView.h"
#import "DKOrderEngineerView.h"
#import "DKFaultDescriptionView.h"
#import "DKMaintenanceRecordView.h"

#import "DKOrderWaitBarView.h"
#import "DKOrderDealBarView.h"
#import "DKOrderContinueDealBarView.h"

@interface DKOrderDetailViewController ()

@property (nonatomic, strong) DKOrderWaitBarView *orderWaitBarView;            // 未接单状态Bar
@property (nonatomic, strong) DKOrderDealBarView *orderDealBarView;            // 处理中状态Bar
@property (nonatomic, strong) DKOrderContinueDealBarView *orderContinueDealBarView; // 继续订单Bar

@property (weak, nonatomic) IBOutlet UIView     *orderStateAddView;                         // 订单状态添加View
@property (nonatomic, strong) DKOrderStateView  *orderStateView;                            // 订单状态View

@property (weak, nonatomic) IBOutlet UIView         *orderUserInfoAddView;                  // 订单用户信息添加View
@property (nonatomic, strong) DKOrderUserInfoView   *orderUserInfoView;                     // 订单用户信息View

@property (weak, nonatomic) IBOutlet UIView             *orderEngineerAddView;              // 订单工程师信息添加View
@property (nonatomic, strong) DKOrderEngineerView       *orderEngineerView;                 // 订单工程师View
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderEngineerViewHeightCons;       // 订单工程师View

@property (weak, nonatomic) IBOutlet UIView             *faultDescriptionAddView;           // 故障描述添加View
@property (nonatomic, strong) DKFaultDescriptionView    *faultDescriptionView;              // 故障描述View
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *faultDescriptionAddViewHeightCons; // 故障描述view高度约束

@property (weak, nonatomic) IBOutlet UIView             *maintenanceRecordAddView;
@property (nonatomic, strong) DKMaintenanceRecordView   *maintenanceRecordView;             // 维修记录View
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *maintenanceRecordViewHeightCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;    // 距离底部约束 有Bar75 无Bar15
@property (weak, nonatomic) IBOutlet UIView             *bottomBarView; // 底部栏View
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (nonatomic, strong) DKOrderDetailViewModel *vm;               // vm

@property (nonatomic, strong) AVAudioPlayer *player;                    // 语音播放器

@end

@implementation DKOrderDetailViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKOrderDetailViewModel)

- (void)setOrderId:(NSString *)orderId
{
    _orderId = orderId;
    self.vm.orderId = orderId;
}

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadData];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"订单详情";
    // 状态
    self.orderStateView = [DKOrderStateView loadView];
    self.orderStateView.orderType = self.orderType;
    [self.orderStateAddView addSubview:self.orderStateView];
    
    @weakify(self);
    // 处理底部bar
    if (self.orderType == DKOrderTypeWait) { // 未接受
        self.orderWaitBarView = [DKOrderWaitBarView loadView];
        [[self.orderWaitBarView.acceptButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            DKAccemptOrderViewController *vc = [[DKAccemptOrderViewController alloc] init];
            vc.modalTransitionStyle = UIModalPresentationCustom;
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            vc.orderId = self.orderId;
            vc.dealBlock = ^(BOOL isDeal) {
                @strongify(self);
                self.orderType = DKOrderTypeDeal;
                [self loadData];
            };
            [self presentViewController:vc animated:YES completion:nil];
        }];
        [[self.orderWaitBarView.turnButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            DKOrderTurnStaffViewController *vc = [[DKOrderTurnStaffViewController alloc] init];
            vc.orderId = self.vm.orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        self.orderWaitBarView.frame = self.bottomBarView.bounds;
        [self.bottomBarView addSubview:self.orderWaitBarView];
        
    } else if (self.orderType == DKOrderTypeDeal) { // 处理中
        self.orderDealBarView = [DKOrderDealBarView loadView];
        // 确认订单
        [[self.orderDealBarView.completeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            DKCompleteOrderViewController *vc = [[DKCompleteOrderViewController alloc] init];
            vc.orderId = self.orderId;
            vc.callBackBlock = ^(BOOL isCallBack) {
                @strongify(self);
                self.orderType = DKOrderTypeComplete;
                [self loadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }];
        // 转派订单
        [[self.orderDealBarView.turnButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            DKOrderTurnStaffViewController *vc = [[DKOrderTurnStaffViewController alloc] init];
            vc.orderId = self.vm.orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        // 取消订单
        [[self.orderDealBarView.cancleOrderButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            DKCancleOrderViewController *vc = [[DKCancleOrderViewController alloc] init];
            vc.callBackBlock = ^(BOOL isCallBack) {
                @strongify(self);
                self.orderType = DKOrderTypeComplete;
                [self loadData];
            };
            vc.orderId = self.orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        // 暂停订单
        [[self.orderDealBarView.pauseButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            DKPauseOrderViewController *vc = [[DKPauseOrderViewController alloc] init];
            vc.modalTransitionStyle = UIModalPresentationCustom;
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            vc.orderId = self.orderId;
            vc.callBackBlock = ^(BOOL isCallBack) {
                @strongify(self);
                self.orderType = DKOrderTypeHang;
                [self loadData];
            };
            [self presentViewController:vc animated:YES completion:nil];
        }];
        self.orderDealBarView.frame = self.bottomBarView.bounds;
        [self.bottomBarView addSubview:self.orderDealBarView];
    } else if (self.orderType == DKOrderTypeHang) {
        // 取消暂停
        self.orderContinueDealBarView = [DKOrderContinueDealBarView loadView];
        [[self.orderContinueDealBarView.continueButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.vm.cancelPauseCommand execute:nil];
        }];
        self.orderContinueDealBarView.frame = self.bottomBarView.bounds;
        [self.bottomBarView addSubview:self.orderContinueDealBarView];
    }
    
    
    // 客户信息
    self.orderUserInfoView = [DKOrderUserInfoView loadView];
    self.orderUserInfoView.orderType = self.orderType;
    [[self.orderUserInfoView rac_signalForSelector:@selector(clickContact)] subscribeNext:^(id x) {
        @strongify(self);
		NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.vm.order.contact_phone];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    [self.orderUserInfoAddView addSubview:self.orderUserInfoView];
    
    // 工程师信息
    self.orderEngineerView = [DKOrderEngineerView loadView];
    self.orderEngineerView.orderType = self.orderType;
    [self.orderEngineerAddView addSubview:self.orderEngineerView];
    
    // 故障描述
    self.faultDescriptionView = [DKFaultDescriptionView loadView];
    self.faultDescriptionView.orderType = self.orderType;
    [[self.faultDescriptionView.voiceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.vm.order.describe_voice]];
        [data writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:@"AudioTempFile"] atomically:YES];
        //将数据amr格式的Data转成wav
        [EMVoiceConverter amrToWav:[NSTemporaryDirectory() stringByAppendingPathComponent:@"AudioTempFile"] wavSavePath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"AudioTempConvertFile"]];
        NSData *convertData = [NSData dataWithContentsOfFile:[NSTemporaryDirectory() stringByAppendingPathComponent:@"AudioTempConvertFile"]];
        self.player = [[AVAudioPlayer alloc] initWithData:convertData error:NULL];
        [self.player prepareToPlay];
        [self.player play];
    }];
    [self.faultDescriptionAddView addSubview:self.faultDescriptionView];
    
    // 维修记录
    self.maintenanceRecordView = [DKMaintenanceRecordView loadView];
    self.maintenanceRecordView.orderType = self.orderType;
    [self.maintenanceRecordAddView addSubview:self.maintenanceRecordView];
    
    // 设置frame
    self.orderStateView.frame = self.orderStateAddView.bounds;
    self.orderUserInfoView.frame = self.orderUserInfoAddView.bounds;
    self.orderEngineerView.frame = self.orderEngineerAddView.bounds;
    
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.fetchOrderDetailCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue] == YES) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
    }];
    
    // 取消暂停暂停
    [self.vm.cancelPauseCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.orderType = DKOrderTypeDeal;
        [DKProgressHUD showSuccessWithStatus:@"恢复订单"];
        [self loadData];
    }];
    
    [[RACObserve(self.vm, order) deliverOnMainThread] subscribeNext:^(DKOrder *order) {
        @strongify(self);
        // 设置View
        [self setUpView];
        
        // 赋值
        self.orderStateView.order = order;
        self.orderUserInfoView.order = order;
        self.orderEngineerView.order = order;
        self.faultDescriptionView.order = order;
        self.maintenanceRecordView.order = order;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 动态修改故障描述View高度
            CGFloat lableHeight = ceilf([self.vm.order.describe_text dk_heightWithContentWidth:DKScreenW - 30 font:[UIFont systemFontOfSize:14]]);
            CGFloat imageHeight = self.vm.order.describe_images.length ? ceilf((DKScreenW - 30) / 3) : 0;
            self.faultDescriptionView.contentLabelHeight.constant = lableHeight;
            self.faultDescriptionAddViewHeightCons.constant = 90 + lableHeight + imageHeight;
            self.faultDescriptionView.frame = self.faultDescriptionAddView.bounds;
        });
        
        if (self.orderType == DKOrderTypeComplete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.bottomCons.constant = 15;
                self.bottomBarView.hidden = YES;
                self.bottomLineView.hidden = YES;
            });
        }
        
        // 当订单类型为未接受时隐藏工程师信息View
        if (self.orderType == DKOrderTypeWait) {
            self.orderEngineerViewHeightCons.constant = 0;
            self.orderEngineerAddView.hidden = YES;
            self.maintenanceRecordViewHeightCons.constant = 0;
            self.maintenanceRecordAddView.hidden = YES;
        } else {
            self.orderEngineerViewHeightCons.constant = 165;
            self.orderEngineerAddView.hidden = NO;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                __block NSInteger height = 0;
                [self.vm.order.record enumerateObjectsUsingBlock:^(DKOrderRecord * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    height = height + [obj rowHeight];
                }];
                self.maintenanceRecordAddView.hidden = NO;
                // 动态修改维修记录高度
                self.maintenanceRecordViewHeightCons.constant = 46 + height;
                self.maintenanceRecordView.frame = self.maintenanceRecordAddView.bounds;
            });
        }
        
    }];
}

- (void)event
{
    
}

- (void)loadData
{
    [self.vm.fetchOrderDetailCommand execute:self.orderId];
}

@end
