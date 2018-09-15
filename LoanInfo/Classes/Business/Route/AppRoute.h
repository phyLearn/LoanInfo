//
//  AppRoute.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/4.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RouteImport.h"

@interface AppRoute : NSObject

//判断登录，控制跳转登录
+ (void)loginComplete:(void(^)(void))complete;

@end
