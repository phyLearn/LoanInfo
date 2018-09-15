//
//  AppRoute+LoanInfoFeedbackRoute.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "AppRoute+LoanInfoFeedbackRoute.h"

@implementation AppRoute (LoanInfoFeedbackRoute)

+ (void)routeToFeedbackWithVC:(UIViewController *)VC paramDict:(NSDictionary *)dict{
    LoanInfoFeedBackViewController *feedBackVC = [[LoanInfoFeedBackViewController alloc] init];
    [feedBackVC setInputParamsDict:dict];
    [VC.navigationController pushViewController:feedBackVC animated:YES];
}

@end
