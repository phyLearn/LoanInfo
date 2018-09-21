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
//    NSArray *rowArr = @[@{@"headerDesc":@"今日推荐",@"bottomDesc":@"简单  快速  借不到",@"money":@"1000-3000元"},@{@"title":@"51钱包-秒到账",@"aDesc":@"秒到账",@"bDesc":@"秒下款",@"maxMoney":@"20000",@"minRate":@"0.21%"},
//                        @{@"title":@"钱花花",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"20000",@"minRate":@"0.21%",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536672406611&di=fea40a4993f2c501f01e239ee5a45cdd&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2034814380%2C1845153858%26fm%3D214%26gp%3D0.jpg"},
//                        @{@"title":@"58钱包",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"30000",@"minRate":@"0.31%",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536672406611&di=fea40a4993f2c501f01e239ee5a45cdd&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2034814380%2C1845153858%26fm%3D214%26gp%3D0.jpg"},
//                        @{@"title":@"江湖应急",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"40000",@"minRate":@"0.41%"},@{@"title":@"支付宝",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"50000",@"minRate":@"0.51%",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536672406611&di=fea40a4993f2c501f01e239ee5a45cdd&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2034814380%2C1845153858%26fm%3D214%26gp%3D0.jpg"},
//                        @{@"title":@"360融",@"aDesc":@"轻松借",@"bDesc":@"审核快",@"maxMoney":@"60000",@"minRate":@"0.61%",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536672406611&di=fea40a4993f2c501f01e239ee5a45cdd&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2034814380%2C1845153858%26fm%3D214%26gp%3D0.jpg"}];
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
