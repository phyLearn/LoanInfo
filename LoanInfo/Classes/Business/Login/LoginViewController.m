//
//  LoginViewController.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/4.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoanInfoLoginImport.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = (id)self;
    
    [[LoanInfoLoginLogicManager shared] startLogicManagerWithViewController:self];
    [[LoanInfoLoginLogicManager shared] registerObserWithDele:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [LoanInfoTools interactivePopGestureRecognizerEnable:NO controllerView:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [LoanInfoTools interactivePopGestureRecognizerEnable:YES controllerView:self];
}

//点击登录按钮
- (void)loginNextBtnAction{
    HYLog(@"登录按钮点击");
}

- (void)dealloc{
    [[LoanInfoLoginLogicManager shared] removeAllObserWithDele:self];
}

@end
