//
//  DKDealWayWikiViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKDealWayWikiViewController.h"

#define DKDealWiki self.orderWikis[self.parentRow].child[self.childRow].child[self.grandsonRow]

@interface DKDealWayWikiViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DKDealWayWikiViewController
static NSString * const kPlanHolderText = @"暂无解决方案";

#pragma mark - setters && getters

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
	[self setupNavigationBar];
    [self event];
}

- (void)setUpView
{
    self.textView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"解决方案";
    self.textView.text = !self.dealWayText.length ? kPlanHolderText : self.dealWayText;
    self.textView.textColor = !self.dealWayText.length ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
	self.textView.editable = DKDealWiki.Id.length ? NO : YES;
}

- (void)dealloc
{
	DKLog(@"DKDealWayWikiViewController");
}

- (void)setupNavigationBar
{
	if (!DKDealWiki.Id.length) { // 系统的不能修改
		UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
		[saveBtn setTitle:@"保存" forState:UIControlStateNormal];
		[saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[saveBtn sizeToFit];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
		@weakify(self);
		[[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
			@strongify(self);
			if ([self.textView.text isEqualToString:kPlanHolderText]) {
				[DKProgressHUD showErrorWithStatus:@"请输入解决方案"];
				return;
			}
			DKDealWiki.fix_plan = self.textView.text;
			DKSetCache(DKUserInfoCache.staff_id, self.orderWikis);
			[self.navigationController popViewControllerAnimated:YES];
			[DKProgressHUD showSuccessWithStatus:@"保存成功"];
		}];
	}
}

#pragma mark - events

- (void)event
{
    
}

#pragma mark - textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:kPlanHolderText]) {
        textView.text = @"";
        textView.textColor = [UIColor darkGrayColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (!textView.text.length) {
        textView.text = kPlanHolderText;
        textView.textColor = [UIColor lightGrayColor];
    }
}

@end
