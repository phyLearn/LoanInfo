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
    NSArray *bannerArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536926420209&di=5317cf924189adb1718ecba783fe5ab9&imgtype=0&src=http%3A%2F%2Fwww.qedai.com%2Fuploads%2Fallimg%2F171123%2F1-1G12311115c47.jpg"];
    [resultDict setObject:bannerArr forKey:@"FirstBannerArr"];
    if(complete)
        complete([resultDict copy]);
}

- (void)getMaxLoanCountComplete:(void(^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSString *maxLoanCount = @"已有12343人借款，最快3分钟放款";
    [resultDict setObject:maxLoanCount forKey:@"maxLoanCount"];
    if(complete)
        complete([resultDict copy]);
}

- (void)getCellDataComplete:(void (^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSArray *rowArr = @[@{@"headerDesc":@"今日推荐",@"bottomDesc":@"简单  快速  借不到",@"money":@"1000-3000元"},@{@"title":@"51钱包-秒到账",@"aDesc":@"秒到账",@"bDesc":@"秒下款",@"maxMoney":@"20000",@"minRate":@"0.21%"},
                        @{@"title":@"钱花花",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"20000",@"minRate":@"0.21%",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536672406611&di=fea40a4993f2c501f01e239ee5a45cdd&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2034814380%2C1845153858%26fm%3D214%26gp%3D0.jpg"},
                        @{@"title":@"58钱包",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"30000",@"minRate":@"0.31%",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536672406611&di=fea40a4993f2c501f01e239ee5a45cdd&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2034814380%2C1845153858%26fm%3D214%26gp%3D0.jpg"},
                        @{@"title":@"江湖应急",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"40000",@"minRate":@"0.41%"},@{@"title":@"支付宝",@"aDesc":@"额度大",@"bDesc":@"审核快",@"maxMoney":@"50000",@"minRate":@"0.51%",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536672406611&di=fea40a4993f2c501f01e239ee5a45cdd&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2034814380%2C1845153858%26fm%3D214%26gp%3D0.jpg"},
                        @{@"title":@"360融",@"aDesc":@"轻松借",@"bDesc":@"审核快",@"maxMoney":@"60000",@"minRate":@"0.61%",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536672406611&di=fea40a4993f2c501f01e239ee5a45cdd&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2034814380%2C1845153858%26fm%3D214%26gp%3D0.jpg"}];
    [resultDict setObject:rowArr forKey:@"rowData"];
    if(complete)
        complete(resultDict);
}

@end
