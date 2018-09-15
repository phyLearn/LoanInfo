//
//  AppRoute+LoanInfoServeOnline.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "AppRoute+LoanInfoServeOnline.h"

@implementation AppRoute (LoanInfoServeOnline)

+ (void)routeToServeOnlineWithVC:(UIViewController *)VC paramDict:(NSDictionary *)dict{
    LoanInfoSeverOnlineViewController *severOnlineVC = [[LoanInfoSeverOnlineViewController alloc] init];
    [severOnlineVC setInputParamsDict:dict];
    [VC.navigationController pushViewController:severOnlineVC animated:YES];
}

@end
