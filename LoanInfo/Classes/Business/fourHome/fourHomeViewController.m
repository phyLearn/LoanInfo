//
//  fourHomeViewController.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/6/29.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "fourHomeViewController.h"
#import "LoanInfoFourImport.h"

@interface fourHomeViewController ()

@end

@implementation fourHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LoanInfoFourLogicManger shared] startLogicManagerWithViewController:self];
    [[LoanInfoFourLogicManger shared] registerObserWithDele:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [LoanInfoTools interactivePopGestureRecognizerEnable:NO controllerView:self];
    [[LoanInfoFourLogicManger shared] refreshHeader];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [LoanInfoTools interactivePopGestureRecognizerEnable:YES controllerView:self];
}

- (void)tableViewDidClick:(NSNotification *)noti{
    NSDictionary *dict = noti.object;
    SEL selector = NSSelectorFromString(dict[@"section"]);
    [self performSelectorOnMainThread:selector withObject:nil waitUntilDone:YES];
}

- (void)loginBtnClick:(NSNotification *)noti{
    //跳转登录
    [AppRoute loginComplete:nil];
}

//跳转意见反馈
- (void)goToFeedBack{
    NSDictionary *dict = @{@"mainUrl":@"https://www.baidu.com"};
    [AppRoute routeToFeedbackWithVC:self paramDict:dict];
}

//跳转在线客服
- (void)goToServeOnline{
    NSDictionary *dict = @{@"mainUrl":@"https://www.baidu.com"};
    [AppRoute routeToServeOnlineWithVC:self paramDict:dict];
}

//跳转帮助中心
- (void)goToHelpCenter{
    NSDictionary *dict = @{@"mainUrl":@"https://www.baidu.com"};
    [AppRoute routeToHelpCenterWithVC:self paramDict:dict];
}

//跳转关于我们
- (void)goToAboutOur{
    NSDictionary *dict = @{@"mainUrl":@"https://www.baidu.com"};
    [AppRoute routeToAboutOurWithVC:self paramDict:dict];
}

//跳转设置
- (void)goToSetting{
    [AppRoute routeToSetingWithVC:self];
}

- (void)dealloc{
    [[LoanInfoFourLogicManger shared] removeAllObserWithDele:self];
}
@end
