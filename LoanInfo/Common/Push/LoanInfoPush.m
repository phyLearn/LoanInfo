//
//  LoanInfoPush.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/10.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoPush.h"
#import "RouteImport.h"

#define PUSHAPPKEY   @"b767085f4b0282f4eb147bf2"

@implementation LoanInfoPush

//初始化SDK
+ (void)startPushWithDele:(id)dele withOptions:(NSDictionary *)launchOptions{
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:dele];
    [JPUSHService setupWithOption:launchOptions appKey:PUSHAPPKEY channel:@"App Store" apsForProduction:NO];
}

//上传deviceToken
+ (void)registerDeviceToken:(NSData *)deviceToken{
    // Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//push的数据处理，根据数据决定跳转
+ (void)disposePushInfoWithDict:(NSDictionary *)dict{
    //这种跳转一般需要考虑几个问题，1：是否登录，未登录的需要优先登录，登录成功之后才能跳转   2:只有用户在外部的推送才能跳转  3：跳转的载体控制器
    //首先设计两种跳转情况 1:直接跳转web页，后台需要返回url 2:跳转商品详情页，后台需要返回商品id
    //对于跳转的载体控制器，我觉得只提供首页跳转比较好管理，就算栈里面已经存在其他控制器，也将所有控制器出栈，然后在首页跳转,这样退出之后都会回到首页，不会在其他乱七八糟的页面
    //对于未登录的情况，需要将推送状态保留，用户完成登录之后需要将跳转流程继续
    
    //商品id
    NSString *productId = @"";
    //商品url
    NSString *productUrl = @"";
    if(![productId isEqualToString:@""]){
        //跳转商品详情页
    }
    
    if(![productUrl isEqualToString:@""]){
        //跳转商品url
    }
}
@end
