//
//  AppFMDB.h
//  AppFramework
//
//  Created by Penghuaiyu on 16/11/21.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppFMDB : NSObject

/**
 *  获取单例对象
 */
+ (instancetype)intance;
/**
 *  判断数据库中是否存在表
 */
- (void)isExistWithTableName:(NSString *)name complete:(void(^)(BOOL isExist))complete;
/**
 *  建立主键ID
 *
 *  @param name     表名
 *  @param keys     字段名数组
 *  @param complete 回调
 */
- (void)createTableWithTableName:(NSString *)name keys:(NSArray *)keys complete:(void (^)(BOOL isSuccess))complete;
/**
 *  插入数据
 *
 *  @param name     表名
 *  @param dict     需要插入的数据模型
 *  @param complete 查询状态回调
 */
- (void)insertIntoTableName:(NSString *)name Dict:(NSDictionary *)dict complete:(void (^)(BOOL isSuccess))complete;
/**
 *  条件查询
 *
 *  @param name     表名
 *  @param keys     key值数组
 *  @param where    查找条件数组
 *  @param complete 回调
 */
- (void)queryWithTableName:(NSString *)name keys:(NSArray *)keys where:(NSArray *)where complete:(void (^)(NSArray *array))complete;

/**
 *  查询所有数据
 *
 *  @param name     表名
 *  @param complete 回调
 */
- (void)queryWithTableName:(NSString *)name complete:(void (^)(NSArray *array))complete;
/**
 *  更新表
 *
 *  @param name      表名
 *  @param valueDict 关键字字典
 *  @param complete  回调
 */
- (void)updateWithTableName:(NSString *)name valueDict:(NSDictionary *)valueDict where:(NSArray *)where complete:(void(^)(BOOL isSuccess))complete;
/**
 *  条件删除
 *
 *  @param name     表名
 *  @param where    条件
 *  @param complete 回调
 */
- (void)deleteWithTableName:(NSString *)name where:(NSArray *)where complete:(void(^)(BOOL isSuccess))complete;
/**
 *  删除表内所有数据
 *
 *  @param name     表名
 *  @param complete 回调
 */
- (void)clearTable:(NSString *)name complete:(void(^)(BOOL isSuccess))complete;
/**
 *  删除表
 *
 *  @param name     表名
 *  @param complete 回调
 */
- (void)dropTable:(NSString *)name complete:(void(^)(BOOL isSuccess))complete;
/**
 *  存储一个对象
 *
 *  @param object   需要存储的对象
 *  @param complete 回调
 */
- (void)saveObject:(id)object complete:(void(^)(BOOL isSuccess))complete;
/**
 *  查询对象
 *
 *  @param cla      需要查询的对象
 *  @param complete 回调
 */
- (void)queryAllObject:(__unsafe_unretained Class)cla complete:(void(^)(NSArray *array))complete;
/**
 *   根据条件查询某个对象
 *
 *  @param cla      对象名
 *  @param keys     keys存放的是要查询的哪些key,为nil时代表查询全部
 *  @param where    查找类型
 *  @param complete  where形式 @[@"key",@"=",@"value",@"key",@">=",@"value"]
 */
- (void)queryObjectWithClass:(__unsafe_unretained Class)cla keys:(NSArray *)keys where:(NSArray *)where complete:(void(^)(NSArray *array))complete;
/**
 根据条件改变对象的值
 valueDict 存放的是key和value
 where数组的形式 @[@"key",@"=",@"value",@"key",@">=",@"value"]
 */
-(void)updateWithClass:(__unsafe_unretained Class)cla valueDict:(NSDictionary*)valueDict where:(NSArray*)where complete:(void (^)(BOOL isSuccess))complete;
/**
 cla代表对应的类
 根据条件删除对象表中的对象数据
 where形式 @[@"key",@"=",@"value",@"key",@">=",@"value"],where要非空
 */
-(void)deleteWithClass:(__unsafe_unretained Class)cla where:(NSArray*)where complete:(void (^)(BOOL isSuccess))complete;
/**
 根据类删除此类所有表数据
 */
-(void)clearWithClass:(__unsafe_unretained Class)cla complete:(void (^)(BOOL isSuccess))complete;
/**
 根据类,删除这个类的表
 */
-(void)dropWithClass:(__unsafe_unretained Class)cla complete:(void (^)(BOOL isSuccess))complete;
@end
