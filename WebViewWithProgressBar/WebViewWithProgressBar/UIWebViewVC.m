//
//  UIWebViewVC.m
//  WebViewWithProgressBar
//
//  Created by CumminsTY on 2018/11/1.
//  Copyright © 2018 --. All rights reserved.
//

#import "UIWebViewVC.h"
#import "WebProgressView.h"
@interface UIWebViewVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webview;
@property (nonatomic, strong) WebProgressView *progressView;
@end

@implementation UIWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"UIWebViewVC";
    [self setup];
    [self loadWebview];
}
-(void)setup{
    self.progressView = [[WebProgressView alloc]initWithFrame:CGRectMake(0, 64, 0, 3)];
    self.progressView.lineColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 67, KScreenWidth, 300)];
    self.webview.backgroundColor = [UIColor clearColor];
    self.webview .opaque = NO;
    self.webview.delegate = self;
    [self.view addSubview:self.webview ];
}

-(void)loadWebview{
    NSString *urlString = @"http://www.baidu.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.timeoutInterval = 15.0f;
    [self.webview loadRequest:request];
}

// 网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.progressView startLoadingAnimation];
}
// 网页完成加载
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.progressView endLoadingAnimation];
}
// 网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.progressView endLoadingAnimation];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
