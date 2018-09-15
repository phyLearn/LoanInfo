//
//  LoanInfoFoutDataManager.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoDataManager.h"

@interface LoanInfoFoutDataManager : LoanInfoDataManager

- (void)getFourCellDataComplete:(void(^)(NSDictionary *dict))complete;

- (void)getFourHeaderDataComplete:(void(^)(NSDictionary *dict))complete;
@end
