//
//  appRoute+LoanInfoWebRoute.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//
#import "AppRoute.h"

@interface AppRoute (LoanInfoWebRoute)

+ (void)routeToWebView:(UIViewController *)VC responseData:(NSDictionary *)response;

@end
