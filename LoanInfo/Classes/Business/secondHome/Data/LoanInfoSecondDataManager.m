//
//  LoanInfoSecondDataManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoSecondDataManager.h"

@implementation LoanInfoSecondDataManager

+(instancetype)shared{
    static LoanInfoSecondDataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[LoanInfoSecondDataManager alloc] init];
    });
    return dataManager;
}

- (void)getBannerDataComplete:(void(^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSArray *bannerArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535983850426&di=71ededd29fb7439a0c903d4066b69dd8&imgtype=0&src=http%3A%2F%2Fp1.gexing.com%2Fshaitu%2F20121113%2F1351%2F50a1dfe8997ae.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535983850426&di=71ededd29fb7439a0c903d4066b69dd8&imgtype=0&src=http%3A%2F%2Fp1.gexing.com%2Fshaitu%2F20121113%2F1351%2F50a1dfe8997ae.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535983850426&di=71ededd29fb7439a0c903d4066b69dd8&imgtype=0&src=http%3A%2F%2Fp1.gexing.com%2Fshaitu%2F20121113%2F1351%2F50a1dfe8997ae.jpg"];
    [resultDict setObject:bannerArr forKey:@"SecondBannerArr"];
    if(complete)
        complete([resultDict copy]);
}

- (void)getScrollTextsDataComplete:(void(^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSArray *scrollTextsArr = @[@"恭喜长沙用户131***2323成功申请***产品100元",
                                @"恭喜长沙用户142***6464成功申请***产品100元",
                                @"恭喜长沙用户150***2932成功申请***产品100元"];
    [resultDict setObject:scrollTextsArr forKey:@"ScrollTextsArr"];
    if(complete)
        complete([resultDict copy]);
}

- (void)getCellDataWithType:(NSString *)type num:(NSString *)num page:(NSString *)page Complete:(void (^)(NSDictionary *dict,NSString *inpage))complete{
    //需要加载个指示框
    [[LoanInfoToast shared] showHUD];
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSDictionary *paramDict = @{@"num":num,
                                @"type":type,
                                @"page":page,
                                @"appid":[[LoanInfoDeviceNews shared] getAppId]
                                };
    [HYNetworkHelper POST:[NSString stringWithFormat:@"%@",@"/api/customer/pager4app2"] parameters:paramDict note:YES success:^(id responseObject){
        [[LoanInfoToast shared] hideHUD];
        if([[responseObject[@"data"] class] isEqual:[NSNull class]]) return;
        NSArray *rowArr = responseObject[@"data"];
        [resultDict setObject:rowArr forKey:@"rowData"];
        if(complete)
            complete(resultDict,page);
    } failure:^(NSError *error) {
        [[LoanInfoToast shared] hideHUD];
    }];
}

- (void)getCellFirstDataWithTimestamp:(NSString *)timestamp num:(NSString *)num Complete:(void (^)(NSDictionary *dict,NSString *inpage))complete{
    [[LoanInfoToast shared] showHUD];
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSDictionary *paramDict = @{@"num":num,
                                @"timestamp":timestamp,
                                @"appid":[[LoanInfoDeviceNews shared] getAppId]
                                };
    [HYNetworkHelper POST:[NSString stringWithFormat:@"%@",@"/api/customer/pager4app"] parameters:paramDict note:YES success:^(id responseObject){
        [[LoanInfoToast shared] hideHUD];
        if([[responseObject[@"data"] class] isEqual:[NSNull class]]) return;
        NSArray *rowArr = responseObject[@"data"];
        [resultDict setObject:rowArr forKey:@"rowData"];
        if(complete)
            complete(resultDict,@"1");
    } failure:^(NSError *error) {
        [[LoanInfoToast shared] hideHUD];
    }];
}

@end
