//
//  AppRoute+LoanInfoFeedbackRoute.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "AppRoute.h"

@interface AppRoute (LoanInfoFeedbackRoute)

+ (void)routeToFeedbackWithVC:(UIViewController *)VC paramDict:(NSDictionary *)dict;

@end
