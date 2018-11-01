//
//  ViewController.m
//  WebViewWithProgressBar
//
//  Created by CumminsTY on 2018/11/1.
//  Copyright © 2018 --. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * titles = @[@"加载UIWebView",@"加载WKWebView"];
    for (int i = 0; i<titles.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.frame = CGRectMake(50, 100+i*80, 200, 50);
        [btn addTarget:self action:@selector(jumpWebview:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)jumpWebview:(UIButton*)sender{
    Class webClass = sender.tag == 0? NSClassFromString(@"UIWebViewVC"):NSClassFromString(@"WKWebViewVC");
    [self.navigationController pushViewController:[webClass new] animated:YES];
    
}

@end
