//
//  AppDatabase.h
//  CardManage
//
//  Created by Penghuaiyu on 2018/8/29.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDatabase : NSObject

/**存储用户登录信息 mobile:用户表名 infoDict:需要存储的信息*/
+ (void)saveUserLoginInfo:(NSDictionary *)infoDict;
//读取用户信息
+ (void)getLoginInfo:(void (^)(NSDictionary *dict))complete;
+ (void)islogin:(void(^)(BOOL isLogin))complete;
+ (void)removeUserLoginInfoComplete:(void(^)(BOOL isSuccess))complete;
@end
