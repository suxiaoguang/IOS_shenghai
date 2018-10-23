//
//  DKSettingAboutViewController.m
//  YouYunBao
//
//  Created by 庄槟豪 on 17/1/13.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKSettingAboutViewController.h"
//#import "AFNetworking.h"
#import "HSUpdateApp.h"

@interface DKSettingAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end

@implementation DKSettingAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    
    self.versionLabel.text = [NSString stringWithFormat:@"v%@", DK_APP_VERSION];
    
//    self.ownerLabel.text = @"盛海HelpDesk Copyright©2017 盛海科技\n 0.1.1201707211424";
	self.ownerLabel.text = [NSString dk_stringWithFormat:@"盛海HelpDesk Copyright©2017 盛海科技\n%@%@",DK_APP_VERSION,DK_APP_BUILD];
	
	[self hsUpdateApp];
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
	[self presentViewController:alercConteoller animated:YES completion:nil];
}

- (IBAction)checkNewVersionBtnClick:(id)sender
{
//    [DKProgressHUD showLoadingToView:self.view];
//    __weak typeof(self) weakSelf = self;
//    
//    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",DKAppStoreID];
//    
//    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [DKProgressHUD dismissForView:weakSelf.view];
//        
//        NSString *newVersion = responseObject[@"results"][0][@"version"];
//        // 以"."分隔数字然后分配到不同数组
//        NSArray *serverArray = [newVersion componentsSeparatedByString:@"."];
//        NSArray *localArray = [DK_APP_VERSION componentsSeparatedByString:@"."];
//        
//        BOOL isNewVersion = NO;
//        for (NSInteger i = 0; i < serverArray.count; i++) {
//            // 以线上版本为基准，判断本地版本位数小于线上版本时，直接返回（并且判断为新版本，比如线上1.5.1 本地为1.5）
//            if (i > (localArray.count -1)) {
//                isNewVersion = YES;
//                break;
//            }
//            // 有新版本，线上版本对应数字大于本地
//            if ([serverArray[i] intValue] > [localArray[i] intValue]) {
//                isNewVersion = YES;
//                break;
//            }
//        }
//        
//        if (isNewVersion) {
//            [self showUpdateTipWithVersion:newVersion trackViewUrl:responseObject[@"results"][0][@"trackViewUrl"]];
//        } else {
//            [DKProgressHUD showInfoWithStatus:@"当前已经是最新版本" toView:self.view];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [DKProgressHUD showErrorWithStatus:DKNetworkError toView:weakSelf.view];
//    }];
}

///**
// 弹出对话框提示有新版本
//
// @param newVersion 新版本号
// */
//- (void)showUpdateTipWithVersion:(NSString *)newVersion trackViewUrl:(NSString *)trackViewUrl
//{
//    NSString *alertMsg = [NSString stringWithFormat:@"顺丰大当家v%@，赶快体验最新版本吧！",newVersion];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        if (trackViewUrl.length) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
//        } else {
//            [DKProgressHUD showErrorWithStatus:DKNetworkError toView:self.view];
//        }
//    }]];
//    
//    [self presentViewController:alert animated:YES completion:nil];
//}

@end
