//
//  LoanInfoUpload.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/22.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoUpload.h"
#import "HYNetworkHelper.h"
#import "JXTAlertView.h"

@implementation LoanInfoUpload

+ (void)showUploadView{
    [self requestUploadData:^(NSDictionary *dict) {
        NSString *title = dict[@"Title"];//标题
        NSNumber *mustUpdate = dict[@"Must_update"];//是否强制更新
        NSString *version = dict[@"Version"];
        NSString *currentVersion = [[LoanInfoDeviceNews shared] getCurrentVersion];//获取当前版本号
        //首先判断是否存在更新
        if([version compare:currentVersion] == NSOrderedDescending){
            //当前版本号小于服务器版本号,需要提示更新
            //需要判断是否需要强制更新
            if([mustUpdate isEqual:@1]){
                //1 需要强制更新
                [JXTAlertView showAlertViewWithTitle:title message:@"检测到更新" cancelButtonTitle:nil buttonIndexBlock:^(NSInteger buttonIndex) {
                    if(0 == buttonIndex){
                        [self openUrl];
                    }
                } otherButtonTitles:@"更新", nil];
            }else{
                //非强制更新
                [JXTAlertView showAlertViewWithTitle:title message:@"检测到更新" cancelButtonTitle:@"取消" buttonIndexBlock:^(NSInteger buttonIndex) {
                    if(1 == buttonIndex){
                        [self openUrl];
                    }
                } otherButtonTitles:@"更新", nil];
            }
        }
    }];
}

+ (void)requestUploadData:(void(^)(NSDictionary *dict))complete{
    [HYNetworkHelper GET:[NSString stringWithFormat:@"%@%@",@"/api/appname/version/",[[LoanInfoDeviceNews shared] getAppId]] parameters:@{} note:YES success:^(id responseObject) {
        if([[responseObject[@"data"] class] isEqual:[NSNull class]]) return;
        complete(responseObject[@"data"]);
    } failure:^(NSError *error) {
    }];
}

//打开saf
+ (void)openUrl{
    NSString * urlStr = [NSString stringWithFormat:@"https://www.baidu.com"];
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{}
                                         completionHandler:^(BOOL success) {
                                             NSLog(@"Open %d",success);
                                         }];
            } else {
                // Fallback on earlier versions
            }
        } else {
            BOOL success = [[UIApplication sharedApplication] openURL:url];
            HYLog(@"Open  %d",success);
        }
        
    } else{
        bool can = [[UIApplication sharedApplication] canOpenURL:url];
        if(can){
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
