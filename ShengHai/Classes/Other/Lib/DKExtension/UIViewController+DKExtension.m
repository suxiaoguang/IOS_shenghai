//
//  NSObject+DKExtension.m
//  DKExtension
//
//  Created by 庄槟豪 on 16/11/23.
//  Edited by Arclin on 16/12/30.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "UIViewController+DKExtension.h"

// 调用这个类的控制器要遵守这个代理<MFMessageComposeViewControllerDelegate>，实现下面的短信协议的方法

@implementation UIViewController (DKExtension)

- (void)dk_showPhoneViewWithPhoneNum:(NSString *)phoneNum
{
    UIWebView *callWebview = [[UIWebView alloc] init];
    // 定义一个通信地址
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    // 用UIWebView加载电话
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    
    // 添加呼叫窗口
    [self.view addSubview:callWebview];
}

- (void)dk_presentMessageViewControllerWithPhoneNum:(NSString *)phoneNum
{
    // 如果设备有发短信功能
    if([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
        // 设置收信人
        messageComposeViewController.recipients = [NSArray arrayWithObject:phoneNum];
        // 设置代理
        messageComposeViewController.messageComposeDelegate = self;
        // 设置当前界面为短信界面
        [self presentViewController:messageComposeViewController animated:YES completion:nil];
    } else {
        [self alertWithTitle:@"提示" msg:@"设备没有发短信功能"];
        NSLog(@"没有发短信功能");
    }
}

- (void)dk_presentEmailViewControllerWithEmails:(NSArray<NSString *> *)emailAddrs subject:(NSString *)subject body:(NSString *)body isHTML:(BOOL)isHtml
{
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:emailAddrs];
    [controller setSubject:subject];
    [controller setMessageBody:body isHTML:isHtml];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - 代理方法

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    switch (result)
    {
        case MessageComposeResultCancelled:
            [self alertWithTitle:@"提示" msg:@"您已取消本次短信发送"];
            break;
        case MessageComposeResultFailed:
            [self alertWithTitle:@"抱歉" msg:@"您的短信发送失败"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示" msg:@"短信发送成功"];
            break;
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    switch (result)
    {
        case MFMailComposeResultCancelled: //取消
            [self alertWithTitle:@"提示" msg:@"您已取消本次邮件发送"];
            break;
        case MFMailComposeResultSaved: // 保存
            [self alertWithTitle:@"提示" msg:@"您已保存邮件"];
            break;
        case MFMailComposeResultSent: // 发送
            [self alertWithTitle:@"提示" msg:@"您已成功发送邮件"];
            break;
        case MFMailComposeResultFailed: // 尝试保存或发送邮件失败
            [self alertWithTitle:@"抱歉" msg:@"您的邮件发送失败"];
            break;
    }
}

#pragma mark - 弹出对话框
- (void)alertWithTitle:(NSString *)title msg:(NSString *)message
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:self
                      cancelButtonTitle:nil
                      otherButtonTitles:@"确定", nil] show];
#pragma clang diagnostic pop
}


@end

