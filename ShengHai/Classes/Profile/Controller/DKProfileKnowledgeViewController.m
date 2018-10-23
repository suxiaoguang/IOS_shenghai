//
//  DKProfileKnowledgeViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/9/12.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileKnowledgeViewController.h"

#import "DKProfileShareKnowledgeViewController.h"
#import "DKProblemTypeViewController.h"

@interface DKProfileKnowledgeViewController ()

@end

@implementation DKProfileKnowledgeViewController
#pragma mark - setters && getters


#pragma mark - lifeCycle
- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setUpView];
	[self event];
}

- (void)setUpView
{
	self.navigationItem.title = @"知识库";
}

// 查看知识库
- (IBAction)clickSeeKnowledgeButton:(id)sender {
	DKProblemTypeViewController *vc = [[DKProblemTypeViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

// 分享知识
- (IBAction)clickShareKnowledgeButton:(id)sender {
	DKProfileShareKnowledgeViewController *vc = [[DKProfileShareKnowledgeViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - events
- (void)bind
{
	
}

- (void)event
{
	
}
@end
