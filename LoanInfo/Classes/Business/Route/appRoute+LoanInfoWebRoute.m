//
//  appRoute+LoanInfoWebRoute.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "appRoute+LoanInfoWebRoute.h"

@implementation AppRoute (LoanInfoWebRoute)

+ (void)routeToWebView:(UIViewController *)VC responseData:(NSDictionary *)response{
    LoanInfoWKWebViewViewController *webVC = [[LoanInfoWKWebViewViewController alloc] init];
    [webVC setInputParamsDict:response];
    [VC.navigationController pushViewController:webVC animated:YES];
}

@end
