//
//  LoanInfoLoginDataManager.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoDataManager.h"

@interface LoanInfoLoginDataManager : LoanInfoDataManager

//请求短信
- (void)sendSmsWithPhone:(NSString *)phone;

//登录接口
- (void)loginWithPhone:(NSString *)phone code:(NSString *)code complete:(void(^)(BOOL isSuccess,NSString *msg))complete;

@end
