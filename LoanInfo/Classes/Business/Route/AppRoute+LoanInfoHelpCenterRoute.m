//
//  AppRoute+LoanInfoHelpCenterRoute.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "AppRoute+LoanInfoHelpCenterRoute.h"

@implementation AppRoute (LoanInfoHelpCenterRoute)

+ (void)routeToHelpCenterWithVC:(UIViewController *)VC paramDict:(NSDictionary *)dict{
    LoanInfoHelpCenterViewController *helperCenterVC = [[LoanInfoHelpCenterViewController alloc] init];
    [helperCenterVC setInputParamsDict:dict];
    [VC.navigationController pushViewController:helperCenterVC animated:YES];
}

@end
