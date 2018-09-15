//
//  AppRoute+LoanInfoSettingRoute.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "AppRoute+LoanInfoSettingRoute.h"

@implementation AppRoute (LoanInfoSettingRoute)

+ (void)routeToSetingWithVC:(UIViewController *)VC{
    LoanInfoSettingViewController *settingVC = [[LoanInfoSettingViewController alloc] init];
    [VC.navigationController pushViewController:settingVC animated:YES];
}

@end
