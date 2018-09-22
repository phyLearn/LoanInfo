//
//  LoanInfoFirstData.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoFirstDataManager.h"
#import "LoanInfoFirstImport.h"

//实现数据层，定义app特定数据，根据自身数据做转发，不被后台数据前者走
@implementation LoanInfoFirstDataManager

+(instancetype)shared{
    static LoanInfoFirstDataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[LoanInfoFirstDataManager alloc] init];
    });
    return dataManager;
}

- (void)getBannerDataComplete:(void(^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    [HYNetworkHelper GET:[NSString stringWithFormat:@"%@%@",@"/api/bannar/get4app/",[[LoanInfoDeviceNews shared] getAppId]] parameters:@{} note:YES success:^(id responseObject) {
        if([[responseObject[@"data"] class] isEqual:[NSNull class]]) return;
        NSMutableArray *imageArr = [NSMutableArray array];
        NSArray *bannerArr = responseObject[@"data"];
        for(NSInteger i = 0; i < bannerArr.count; i++){
            NSDictionary *dict = bannerArr[i];
            NSString *logopath = [NSString stringWithFormat:@"%@%@",URLHOST,dict[@"Img"]];
            [imageArr addObject:logopath];
        }
        [resultDict setObject:imageArr forKey:@"FirstBannerArr"];
        [resultDict setObject:bannerArr forKey:@"BannerArr"];
        if(complete)
            complete(resultDict);
    } failure:^(NSError *error) {
    }];
}

- (void)getMaxLoanCountComplete:(void(^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    [HYNetworkHelper GET:[NSString stringWithFormat:@"%@%@",@"/api/appname/get4app/",[[LoanInfoDeviceNews shared] getAppId]] parameters:@{} note:YES success:^(id responseObject) {
        if([[responseObject[@"data"] class] isEqual:[NSNull class]]) return;
        NSString *maxLoanCount = [NSString stringWithFormat:@"已有%@人借款，最快3分钟放款",responseObject[@"data"]];
        [resultDict setObject:maxLoanCount forKey:@"maxLoanCount"];
        if(complete)
            complete([resultDict copy]);
    } failure:^(NSError *error) {
    }];
}

- (void)getCellDataComplete:(void (^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    [HYNetworkHelper GET:[NSString stringWithFormat:@"%@%@",@"/api/customer/list4app/",[[LoanInfoDeviceNews shared] getAppId]] parameters:@{} note:YES success:^(id responseObject) {
        if([[responseObject[@"data"] class] isEqual:[NSNull class]]) return;
        NSArray *rowArr = responseObject[@"data"];
        [resultDict setObject:rowArr forKey:@"rowData"];
        if(complete)
            complete(resultDict);
    } failure:^(NSError *error) {
    }];
}

@end
