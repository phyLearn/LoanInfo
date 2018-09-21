//
//  LoanInfoProductsLogicManager.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoMainLogicManager.h"

typedef enum {
    nextBtnEnum = 0//立即借款按钮点击
}completeEnum;

@interface LoanInfoProductsLogicManager : LoanInfoMainLogicManager

- (void)startLogicManagerWithViewController:(UIViewController *)vc paramDict:(NSDictionary *)paramDict complete:(void(^)(completeEnum sonCompleteEnum,NSDictionary *responseDict))complete;

@end
