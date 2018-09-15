//
//  LoanInfoPush.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/10.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface LoanInfoPush : NSObject

//初始化
+ (void)startPushWithDele:(id)dele withOptions:(NSDictionary *)launchOptions;

//上传deviceToken
+ (void)registerDeviceToken:(NSData *)deviceToken;

//处理推送数据并决定跳转
+ (void)disposePushInfoWithDict:(NSDictionary *)dict;
@end
