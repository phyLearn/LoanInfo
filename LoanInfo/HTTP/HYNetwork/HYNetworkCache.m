//
//  HYNetworkCache.m
//  HYAppCollect
//
//  Created by Penghuaiyu on 16/8/26.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import "HYNetworkCache.h"
#import "YYCache.h"

@implementation HYNetworkCache
//定义常量不被修改
static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;

+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

+ (void)saveResponseCache:(id)responseCache forKey:(NSString *)key
{
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:responseCache forKey:key withBlock:nil];
}

+ (id)getResponseCacheForKey:(NSString *)key
{
    return [_dataCache objectForKey:key];
}

@end
