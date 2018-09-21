//
//  LoanInfoLocation.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanInfoLocation : NSObject

+(instancetype)shared;

- (void)startLocal:(void(^)(NSDictionary *info))complete;

@end
