//
//  DKWebViewController.m
//  YouYunBao
//
//  Created by 庄槟豪 on 2016/12/24.
//  Copyright © 2016年 cn.dankal. All rights reserved.
//

#import "DKWebViewController.h"

@import WebKit;

@interface DKWebViewController () <WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, weak) WKWebView *webView;
@end

@implementation DKWebViewController

#pragma mark - Setter && Getter

- (WKWebView *)webView
{
    if (!_webView) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, DKScreenW, DKScreenH)];
        webView.backgroundColor = DKColorLineLightGray;
        webView.opaque = NO;
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)setH5Content:(NSString *)h5Content
{
    _h5Content = h5Content;
    
    [self.webView loadHTMLString:h5Content baseURL:nil];
}

#pragma mark - Life Cycle

+ (instancetype)webViewWithUrl:(NSString *)url
{
    return [[self alloc] initWithUrl:url];
}

+ (instancetype)webViewWithH5Content:(NSString *)h5Content
{
    return [[self alloc] initWithH5Content:h5Content];
}

- (instancetype)initWithUrl:(NSString *)url
{
    self.url = url;
    return self;
}

- (instancetype)initWithH5Content:(NSString *)h5Content
{
    self.h5Content = h5Content;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self webView];
}

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
//{
//    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        self.title = result;
//    }];
//}

@end
