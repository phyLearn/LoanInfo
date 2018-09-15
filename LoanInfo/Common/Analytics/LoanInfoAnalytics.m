//
//  LoanInfoAnalytics.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/10.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoAnalytics.h"
#import "UMMobClick/MobClick.h"

@implementation LoanInfoAnalytics

//初始化统计
+ (void)startAnalytics{
    UMConfigInstance.appKey = @"5b9623f6a40fa3643a000076";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}

+ (void)beginPageWithPageName:(NSString *)name{
    [MobClick beginLogPageView:name];//("PageOne"为页面名称，可自定义)
}

+ (void)endPageWithPageName:(NSString *)name{
    [MobClick endLogPageView:name];
}

+ (void)clickEventWithId:(NSString *)eventId attributes:(NSDictionary *)attributes{
    [MobClick event:eventId attributes:attributes];
}

@end
