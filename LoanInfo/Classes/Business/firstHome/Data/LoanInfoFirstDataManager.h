//
//  LoanInfoFirstData.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoDataManager.h"

@interface LoanInfoFirstDataManager : LoanInfoDataManager

- (void)getBannerDataComplete:(void(^)(NSDictionary *dict))complete;

- (void)getMaxLoanCountComplete:(void(^)(NSDictionary *dict))complete;

//获得具体商品信息
- (void)getCellDataComplete:(void (^)(NSDictionary *dict))complete;
@end
