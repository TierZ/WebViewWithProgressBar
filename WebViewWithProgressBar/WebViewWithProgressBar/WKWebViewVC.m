//
//  WKWebViewVC.m
//  WebViewWithProgressBar
//
//  Created by CumminsTY on 2018/11/1.
//  Copyright © 2018 --. All rights reserved.
//

#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>
@interface WKWebViewVC ()
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"WKWebViewVC";
    
    [self setup];
    [self addObserve];
    [self loadwk];
    // Do any additional setup after loading the view.
}

-(void)setup{
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 70, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.tintColor = [UIColor blueColor];
    self.progressView.backgroundColor = [UIColor lightGrayColor];

    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    
    WKWebViewConfiguration * wkconfig = [[WKWebViewConfiguration alloc] init];
    wkconfig.allowsInlineMediaPlayback = YES;
    wkconfig.allowsPictureInPictureMediaPlayback = YES;
    
    self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 72, [[UIScreen mainScreen] bounds].size.width, 400) configuration:wkconfig];
    [self.view addSubview:self.wkWebView];
    
}

-(void)loadwk{
    NSString *urlString = @"http://www.baidu.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.timeoutInterval = 15.0f;
    [self.wkWebView loadRequest:request];
}

-(void)addObserve{
     [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}




#pragma mark - 监听

/*
 *4.在监听方法中获取网页加载的进度，并将进度赋给progressView.progress
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
         
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKWKNavigationDelegate Methods

/*
 *5.在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条
 */

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    //    self.progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}

//页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //允许页面跳转
    NSLog(@"%@",navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
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
