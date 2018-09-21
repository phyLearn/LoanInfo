//
//  LoanInfoCache.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoCache.h"
#import "YYCache.h"

//定义常量不被修改
static NSString *const CMPSaticCache = @"LoanInfoSaticCache";
static YYCache *_dataCache;

@implementation LoanInfoCache

+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:CMPSaticCache];
}

+ (void)saveCacheWithValue:(id)value key:(NSString *)key{
    [_dataCache setValue:value forKey:key];
}

+ (id)getCacheWithKey:(NSString *)key{
    return [_dataCache objectForKey:key];
}

@end
