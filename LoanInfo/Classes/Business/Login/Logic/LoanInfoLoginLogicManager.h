//
//  LoanInfoLoginLogicManager.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoMainLogicManager.h"

@interface LoanInfoLoginLogicManager : LoanInfoMainLogicManager

//退出登录
- (void)quitLoginComplete:(void(^)(void))complete;

@end
