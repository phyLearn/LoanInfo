//
//  LoanInfoSecondDataManager.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoDataManager.h"

@interface LoanInfoSecondDataManager : LoanInfoDataManager

- (void)getBannerDataComplete:(void(^)(NSDictionary *dict))complete;

- (void)getScrollTextsDataComplete:(void(^)(NSDictionary *dict))complete;

- (void)getCellDataWithType:(NSString *)type num:(NSString *)num page:(NSString *)page Complete:(void (^)(NSDictionary *dict,NSString *inpage))complete;
//请求新口子
- (void)getCellFirstDataWithTimestamp:(NSString *)timestamp num:(NSString *)num Complete:(void (^)(NSDictionary *dict,NSString *inpage))complete;
@end
