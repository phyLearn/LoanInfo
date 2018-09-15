//
//  LoanInfoProductsDataManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoProductsDataManager.h"

@implementation LoanInfoProductsDataManager

+(instancetype)shared{
    static LoanInfoProductsDataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[LoanInfoProductsDataManager alloc] init];
    });
    return dataManager;
}

- (void)getProdictsResponseData:(void(^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    [resultDict setObject:@"https://www.baidu.com" forKey:@"mainUrl"];
    //添加产品信息
    NSArray *productsData = @[@{@"cellTitle":@"产品特色",@"cellContent":@"新口子，申请简单，通过率高"},
                              @{@"cellTitle":@"所需资料",@"cellContent":@"身份证 手机号 支付宝 微信 工作地点"},
                              @{@"cellTitle":@"申请条件",@"cellContent":@"学生不可申请，限20-40岁用户申请"}
                              ];
    [resultDict setObject:productsData forKey:@"productsArr"];
    //添加头部信息
    [resultDict setObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536672406611&di=fea40a4993f2c501f01e239ee5a45cdd&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2034814380%2C1845153858%26fm%3D214%26gp%3D0.jpg" forKey:@"productsImage"];
    [resultDict setObject:@"随心回收" forKey:@"productsTitle"];
    [resultDict setObject:@"1000已放款" forKey:@"productsPeople"];
    [resultDict setObject:@"1000-3000元" forKey:@"productsMoney"];
    [resultDict setObject:@"1-7天" forKey:@"productsTime"];
    [resultDict setObject:@"0.11%" forKey:@"productsGate"];
    if(complete)
        complete([resultDict copy]);
}

@end
