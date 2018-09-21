//
//  LoanInfoCache.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanInfoCache : NSObject

+ (void)saveCacheWithValue:(id)value key:(NSString *)key;

+ (id)getCacheWithKey:(NSString *)key;

@end
