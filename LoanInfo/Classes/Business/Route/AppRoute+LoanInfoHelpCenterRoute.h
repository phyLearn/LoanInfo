//
//  AppRoute+LoanInfoHelpCenterRoute.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "AppRoute.h"

@interface AppRoute (LoanInfoHelpCenterRoute)

+ (void)routeToHelpCenterWithVC:(UIViewController *)VC paramDict:(NSDictionary *)dict;

@end
