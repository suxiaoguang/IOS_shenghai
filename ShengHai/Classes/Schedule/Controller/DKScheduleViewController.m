//
//  DKScheduleViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/16.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKScheduleViewController.h"
#import "DKScheduleListViewController.h"
#import "DKProfileNotificationViewController.h"

#import "DKScheduleIndicatorView.h"
#import "ALCalendarPicker.h"
#import "DKNoticeBarButtonItemView.h"

#import "DKNoticeViewModel.h"

#define DKCalendarPickerMargin      ((DKScreenW - 40) - (7 * DKScreenW / 10)) / 7
#define DKCalendarPickerHeight      45 + DKScreenW / 10 * 7 + DKCalendarPickerMargin * 8

#define DKScheduleIndicatorViewY    self.calendarPicker.y + DKCalendarPickerHeight

@interface DKScheduleViewController () <ALCalendarPickerDelegate>
@property (nonatomic, strong) ALCalendarPicker *calendarPicker;
@property (nonatomic, strong) DKNoticeViewModel *vm;
@end

@implementation DKScheduleViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKNoticeViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupNavItem];
    [self setUpView];
    [self event];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.vm.param.scheduleYear = [NSDate dk_currentDateStrWithFormat:@"yyyy"];
    self.vm.param.scheduleMonth = [NSDate dk_currentDateStrWithFormat:@"MM"];
    [self.vm.fetchMonthCalendarCommand execute:nil];
    
    [self.vm.fetchNoticeUnreadCommand execute:nil];
    
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

- (void)setUpView
{
    self.navigationItem.title = @"日程";

    self.calendarPicker = [[ALCalendarPicker alloc] initWithFrame:CGRectMake(0, 84, DKScreenW, DKCalendarPickerHeight)];
    self.calendarPicker.delegate = self;
    //
    [self.calendarPicker setupTodayItemStyle:^(UIColor *__autoreleasing *backgroundColor, NSNumber *__autoreleasing *backgroundCornerRadius, UIColor *__autoreleasing *titleColor) {
        *backgroundColor = DKColorTintMain;
        *backgroundCornerRadius = @(DKScreenW / 20);
        *titleColor = [UIColor whiteColor];
        
    }];
    
    [self.calendarPicker setupHightLightItemStyle:^(UIColor *__autoreleasing *backgroundColor, NSNumber *__autoreleasing *backgroundCornerRadius, UIColor *__autoreleasing *titleColor) {
        *backgroundColor = [UIColor dk_colorWithHexString:@"f5a623"];
        *titleColor = [UIColor whiteColor];
        *backgroundCornerRadius = @(5.0);
    }];
    
    self.calendarPicker.beginYearMonth = [NSDate dk_currentDateStrWithFormat:@"yyyy-MM"];
    
    self.calendarPicker.hightlightPriority = YES;
    

    [self.view addSubview:self.calendarPicker];
    
    DKScheduleIndicatorView *scheduleIndicatorView = [DKScheduleIndicatorView loadView];
    scheduleIndicatorView.frame = CGRectMake(0, DKScheduleIndicatorViewY, DKScreenW, 50);
    [self.view addSubview:scheduleIndicatorView];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.fetchNoticeUnreadCommand.executionSignals.switchToLatest subscribeNext:^(NSString *x) {
        @strongify(self);
        DKNoticeBarButtonItemView *contentView = self.navigationItem.rightBarButtonItem.customView;
        contentView.smallRedView.hidden = x.integerValue > 0 ? NO : YES;
    }];
    
    [self.vm.fetchMonthCalendarCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.calendarPicker.hightLightItems = self.vm.monthCalendar.timeArray;
//		self.calendarPicker.hightLightItems = @[@"2017-09-29", @"2017-09-28"];
        [self.calendarPicker reloadPicker];
    }];
}

- (void)event
{
    
}

#pragma mark - ALCalendarPickerDelegate
- (void)calendarPicker:(ALCalendarPicker *)picker didSelectItem:(ALCalendarDate *)date date:(NSDate *)dateObj dateString:(NSString *)dateStr
{
    [self.calendarPicker.hightLightItems enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([dateStr isEqualToString:obj]) {
            DKScheduleListViewController *vc = [[DKScheduleListViewController alloc] init];
            vc.dateTitle = [dateObj dk_dateStrWithFormat:@"MM月-dd日安排"];
            vc.date = dateObj;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

@end
