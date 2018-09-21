//
//  LoanInfoProductsDataManager.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoDataManager.h"

@interface LoanInfoProductsDataManager : LoanInfoDataManager

- (void)getProdictsResponseData:(NSString *)listId complete:(void(^)(NSDictionary *dict))complete;

@end
