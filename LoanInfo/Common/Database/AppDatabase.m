//
//  AppDatabase.m
//  CardManage
//
//  Created by Penghuaiyu on 2018/8/29.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//
//用户存储用户基本信息
#import "AppDatabase.h"
#import "AppFMDB.h"

@implementation AppDatabase

+ (void)saveUserLoginInfo:(NSDictionary *)infoDict{
    //首先判断是否存在表
    NSString *tableName = [NSString stringWithFormat:@"loginInfo"];
    [[AppFMDB intance] isExistWithTableName:tableName complete:^(BOOL isExist) {
       //已经存在则直接存储，不存在则创建之后再存储
        if(isExist){
            HYLog(@"用户信息表已经存在");
            return;
        }
        //创建表
        [[AppFMDB intance] createTableWithTableName:tableName keys:infoDict.allKeys complete:^(BOOL isSuccess) {
            if(isSuccess){
                HYLog(@"用户信息表创建成功");
            }
        }];
    }];
}

+ (void)removeUserLoginInfoComplete:(void(^)(BOOL isSuccess))complete{
    NSString *tableName = [NSString stringWithFormat:@"loginInfo"];
    [[AppFMDB intance] dropTable:tableName complete:^(BOOL isSuccess) {
        complete(isSuccess);
    }];
}

//判断登录状态，存在表即已经登录
+ (void)islogin:(void(^)(BOOL isLogin))complete{
    NSString *tableName = [NSString stringWithFormat:@"loginInfo"];
    [[AppFMDB intance] isExistWithTableName:tableName complete:^(BOOL isExist) {
        //已经存在则直接存储，不存在则创建之后再存储
        if(isExist){
            HYLog(@"用户信息表已经存在");
            if(complete)
                complete(YES);
            return;
        }
        if(complete)
            complete(NO);
    }];
}

@end
