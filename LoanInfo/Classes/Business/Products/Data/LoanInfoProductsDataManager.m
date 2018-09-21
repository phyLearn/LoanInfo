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

- (void)getProdictsResponseData:(NSString *)listId complete:(void(^)(NSDictionary *dict))complete{
    [[LoanInfoToast shared] showHUD];
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    [HYNetworkHelper GET:[NSString stringWithFormat:@"%@%@",@"/api/customer/get4app/",listId] parameters:@{} note:YES success:^(id responseObject){
        [[LoanInfoToast shared] hideHUD];
        if([[responseObject[@"data"] class] isEqual:[NSNull class]]) return;
        
        NSDictionary *dataDict = responseObject[@"data"];
        [resultDict setObject:dataDict[@"seo_url"] forKey:@"mainUrl"];
        //添加产品信息
        NSArray *productsData = @[@{@"cellTitle":@"产品特色",@"cellContent":@"新口子，申请简单，通过率高"},
                                  @{@"cellTitle":@"所需资料",@"cellContent":@"身份证 手机号 支付宝 微信 工作地点"},
                                  @{@"cellTitle":@"申请条件",@"cellContent":@"学生不可申请，限20-40岁用户申请"}
                                  ];
        [resultDict setObject:productsData forKey:@"productsArr"];
        //添加头部信息
        [resultDict setObject:dataDict[@"logo"] forKey:@"productsImage"];
        [resultDict setObject:dataDict[@"name"] forKey:@"productsTitle"];
        [resultDict setObject:[NSString stringWithFormat:@"%@已放款",dataDict[@"loans"]] forKey:@"productsPeople"];
        [resultDict setObject:[NSString stringWithFormat:@"%@-%@元",dataDict[@"min"],dataDict[@"max"]] forKey:@"productsMoney"];
        switch ([dataDict[@"scope"] integerValue]) {
            case 0:
            {
                [resultDict setObject:@"未知" forKey:@"productsTime"];
            }
                break;
            case 1:
            {
                [resultDict setObject:@"不限" forKey:@"productsTime"];
            }
                break;
            case 2:
            {
                [resultDict setObject:@"长期" forKey:@"productsTime"];
            }
                break;
            case 3:
            {
                [resultDict setObject:@"一年" forKey:@"productsTime"];
            }
                break;
            case 4:
            {
                [resultDict setObject:@"半年" forKey:@"productsTime"];
            }
                break;
            case 5:
            {
                [resultDict setObject:@"30天" forKey:@"productsTime"];
            }
                break;
            case 6:
            {
                [resultDict setObject:@"14天" forKey:@"productsTime"];
            }
                break;
            case 7:
            {
                [resultDict setObject:@"1-7天" forKey:@"productsTime"];
            }
                break;
            default:
                break;
        }
        [resultDict setObject:[NSString stringWithFormat:@"%@%@",dataDict[@"rate"],@"%"] forKey:@"productsGate"];
        
        if(complete)
            complete(resultDict);
    } failure:^(NSError *error) {
        [[LoanInfoToast shared] hideHUD];
    }];
}

@end
