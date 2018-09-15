//
//  LoanInfoAnalytics.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/10.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanInfoAnalytics : NSObject

//初始化统计
+ (void)startAnalytics;

//开始某个页面
+ (void)beginPageWithPageName:(NSString *)name;

//结束某个页面
+ (void)endPageWithPageName:(NSString *)name;

//统计点击事件
+ (void)clickEventWithId:(NSString *)eventId attributes:(NSDictionary *)attributes;
@end
