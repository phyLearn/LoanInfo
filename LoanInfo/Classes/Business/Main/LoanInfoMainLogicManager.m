//
//  LoanInfoMainLogicManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoMainLogicManager.h"

@implementation LoanInfoMainLogicManager


- (void)removeAllObserWithDele:(id)delegate{
    [[NSNotificationCenter defaultCenter] removeObserver:delegate];
}

@end
