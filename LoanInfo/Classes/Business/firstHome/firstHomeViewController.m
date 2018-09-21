//
//  firstHomeViewController.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/6/29.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "firstHomeViewController.h"
#import "LoanInfoFirstImport.h"

@interface firstHomeViewController ()

@end

@implementation firstHomeViewController

static NSString *const mainCell = @"AppMainCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[LoanInfoFirstLogicManager shared] startLogicManagerWithViewController:self];
    [[LoanInfoFirstLogicManager shared] registerObserWithDele:self];
    
    //判断登录
    [AppRoute loginComplete:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [LoanInfoAnalytics beginPageWithPageName:@"主页"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [LoanInfoTools interactivePopGestureRecognizerEnable:NO controllerView:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [LoanInfoAnalytics endPageWithPageName:@"主页"];
    [LoanInfoTools interactivePopGestureRecognizerEnable:YES controllerView:self];
}

- (void)tableViewDidClick:(NSNotification *)noti{
    HYLog(@"tableViewDidClick");
    NSDictionary *userinfo = noti.object;
    [AppRoute routeToProductsVC:self paramDict:userinfo];
}

- (void)dealloc{
    [[LoanInfoFirstLogicManager shared] removeAllObserWithDele:self];
}

@end
