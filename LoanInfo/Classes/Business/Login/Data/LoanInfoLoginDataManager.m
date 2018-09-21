//
//  LoanInfoLoginDataManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoLoginDataManager.h"
#import "LoanInfoDeviceNews.h"

@implementation LoanInfoLoginDataManager

+(instancetype)shared{
    static LoanInfoLoginDataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[LoanInfoLoginDataManager alloc] init];
    });
    return dataManager;
}

//回调 isSuccess代表登录状态  msg代表报错信息，成功没有报错
- (void)loginWithPhone:(NSString *)phone code:(NSString *)code complete:(void(^)(BOOL isSuccess,NSString *msg))complete{
    
    NSString *appId = [[LoanInfoDeviceNews shared] getAppId];
    NSString *info = [[LoanInfoDeviceNews shared] getCurrentDeviceModel];
    NSString *ver = [[LoanInfoDeviceNews shared] getCurrentVersion];
    
    __block NSString *getlon = [NSString string];
    __block NSString *getlat = [NSString string];
    
    [[LoanInfoToast shared] showHUD];
    //这里需要设置同步，直到定位完成,使用信号量阻塞进程
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //创建
    [[LoanInfoDeviceNews shared] getLocalInfo:^(NSString *lon, NSString *lat) {
        getlon = lon;
        getlat = lat;
        //直到这里执行才会继续流程
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSDictionary *parmDict = @{
                               @"Appid":appId,//appid
                               @"Phone":phone,
                               @"Sys":@"2",//手机系统，苹果为2
                               @"Info":info,//手机机型
                               @"Ver":ver,//版本号
                               @"Lon":getlon,//经度
                               @"Code":code,//验证码
                               @"Lat":getlat //纬度
                               };
    [HYNetworkHelper POST:@"/api/user/login" parameters:parmDict note:YES success:^(id responseObject) {
        [[LoanInfoToast shared] hideHUD];
        HYLog(@"responseObject  %@",responseObject);
        BOOL isSuccess = [responseObject[@"ret"] integerValue];
        NSString *message = [NSString string];
        if(!isSuccess){
            message = @"注册失败";
        }
        complete(isSuccess,message);
    } failure:^(NSError *error) {
        [[LoanInfoToast shared] hideHUD];
    }];
}

//发送验证码
- (void)sendSmsWithPhone:(NSString *)phone{
    [HYNetworkHelper GET:[NSString stringWithFormat:@"api/sms/send/%@",phone] parameters:@{} note:YES success:^(id responseObject) {
    } failure:^(NSError *error) {
    }];
}
@end
