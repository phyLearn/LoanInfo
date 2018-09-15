//
//  LoanInfoWKWebViewViewController.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoWKWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface LoanInfoWKWebViewViewController ()
<
    WKNavigationDelegate,
    WKUIDelegate
>

@property (nonatomic, strong) WKWebView *mainWebView;

@end

@implementation LoanInfoWKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

//上个界面传入的参数
- (void)setInputParamsDict:(NSDictionary *)inputDict{
     [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:inputDict[@"mainUrl"]]]];
}

- (WKWebView *)mainWebView{
    if(!_mainWebView){
        _mainWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
        _mainWebView.backgroundColor = [UIColor whiteColor];
        _mainWebView.navigationDelegate = self;
        //支持滑动返回
        _mainWebView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:_mainWebView];
    }
    return _mainWebView;
}

//页面开始加载调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    self.title = webView.title;
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
}
@end
