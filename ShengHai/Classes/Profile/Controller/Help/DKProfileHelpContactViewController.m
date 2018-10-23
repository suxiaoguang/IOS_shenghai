//
//  DKProfileHelpContactViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileHelpContactViewController.h"
#import "DKQrcodeViewController.h"

#import "DKProfileHelpViewModel.h"

@interface DKProfileHelpContactViewController ()

@property (nonatomic, strong) DKProfileHelpViewModel *vm;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *wechatTap;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *phoneTap;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *bgViewTap;

@end

@implementation DKProfileHelpContactViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKProfileHelpViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [self.vm.fetchContactInformationCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
    }];
}

- (void)event
{
    @weakify(self);
    [self.vm.fetchContactInformationCommand execute:nil];
    
    [self.wechatTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        if (self.vm.contactInformation.wechat.length) {
             DKLog(@"%@",self.vm.contactInformation.wechat);
            [self dismissViewControllerAnimated:NO completion:^{
                DKQrcodeViewController *vc = [[DKQrcodeViewController alloc] init];
                vc.qrcodeUrl = self.vm.contactInformation.wechat;
                vc.modalTransitionStyle = UIModalPresentationCustom;
                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
            }];
        }
    }];
    
    [self.phoneTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        if (self.vm.contactInformation.phone.length) {
            DKLog(@"%@",self.vm.contactInformation.phone);
            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", self.vm.contactInformation.phone];
            UIWebView *callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
    }];
    
    [self.bgViewTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
