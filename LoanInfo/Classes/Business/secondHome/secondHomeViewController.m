//
//  secondHomeViewController.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/6/29.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "secondHomeViewController.h"
#import "LoanInfoSecondImport.h"

@interface secondHomeViewController ()

@end

@implementation secondHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[LoanInfoSecondLogicManager shared] startLogicManagerWithSecondViewController:self];
    [[LoanInfoSecondLogicManager shared] registerObserWithDele:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [LoanInfoTools interactivePopGestureRecognizerEnable:NO controllerView:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [LoanInfoTools interactivePopGestureRecognizerEnable:YES controllerView:self];
}

- (void)tableViewDidClick{
    HYLog(@"tableViewDidClick");
    [AppRoute routeToProductsVC:self];
}

- (void)dealloc{
    [[LoanInfoSecondLogicManager shared] removeAllObserWithDele:self];
}

@end
