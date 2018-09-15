//
//  AppRoute+LoanInfoAboutOurRoute.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "AppRoute+LoanInfoAboutOurRoute.h"

@implementation AppRoute (LoanInfoAboutOurRoute)

+ (void)routeToAboutOurWithVC:(UIViewController *)VC paramDict:(NSDictionary *)dict{
    LoanInfoAboutOurViewController *abountOurVC = [[LoanInfoAboutOurViewController alloc] init];
    [abountOurVC setInputParamsDict:dict];
    [VC.navigationController pushViewController:abountOurVC animated:YES];
}

@end
