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
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
//    NSArray *rowArr = @[@{@"headerDesc":@"四分钟放款，贷款不再难",@"bottomDesc":@"简单  快速  借不到"},@{@"title":@"51钱包-秒到账",@"aDesc":@"秒到账",@"bDesc":@"秒下款",@"maxMoney":@"20000",@"minRate":@"0.21%"},
//                        @{@"title":@"钱花花",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"20000",@"minRate":@"0.21%",@"imageUrl":@""},
//                        @{@"title":@"58钱包",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"30000",@"minRate":@"0.31%",@"imageUrl":@""},
//                        @{@"title":@"江湖应急",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"40000",@"minRate":@"0.41%"},@{@"title":@"支付宝",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"50000",@"minRate":@"0.51%",@"imageUrl":@""},
//                        @{@"title":@"360融",@"aDesc":@"轻松借",@"bDesc":@"审核快",@"maxMoney":@"60000",@"minRate":@"0.61%",@"imageUrl":@""}];
    NSDictionary *paramDict = @{@"num":num,
                                @"type":type,
                                @"page":page,
                                @"appid":[[LoanInfoDeviceNews shared] getAppId]
                                };
    [HYNetworkHelper POST:[NSString stringWithFormat:@"%@",@"/api/customer/pager4app2"] parameters:paramDict note:YES success:^(id responseObject){
        if([[responseObject[@"data"] class] isEqual:[NSNull class]]) return;
        NSArray *rowArr = responseObject[@"data"];
        [resultDict setObject:rowArr forKey:@"rowData"];
        if(complete)
            complete(resultDict,page);
    } failure:^(NSError *error) {
    }];
}

@end
