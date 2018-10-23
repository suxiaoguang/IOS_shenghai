//
//  DKProfileHelpViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/21.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileHelpViewController.h"
#import "DKProfileHelpContactViewController.h"
#import "DKProfileHelpRulesViewController.h"
#import "DKUserChangePhoneViewController.h"

#import "DKProfileHelpViewModel.h"

#import "DKProfileHelpCell.h"

@interface DKProfileHelpViewController ()

@property (nonatomic, strong) DKProfileHelpViewModel *vm;

@end

@implementation DKProfileHelpViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKProfileHelpViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"帮助";
}

#pragma mark - events
- (void)bind
{}

- (void)event
{}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vm.viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DKProfileHelpCell cellWithTableView:tableView indexPath:indexPath viewModel:self.vm];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.vm.viewControllers[indexPath.row];

    if (indexPath.row == 3) { // 联系客服
        DKProfileHelpContactViewController *vc = [[DKProfileHelpContactViewController alloc] init];
        vc.modalTransitionStyle = UIModalPresentationCustom;
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:vc animated:YES completion:nil];
    } else if (indexPath.row == 4) {
        DKUserChangePhoneViewController *vc = [[DKUserChangePhoneViewController alloc] init];
        vc.changeType = DKChangeTypePassword;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 5) {
        DKUserChangePhoneViewController *vc = [[DKUserChangePhoneViewController alloc] init];
        vc.changeType = DKChangeTypePhone;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        if (name.length) {
            Class   clazz = NSClassFromString(name);
            id      target = [[clazz alloc] init];
            [self.navigationController pushViewController:target animated:YES];
        }
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
