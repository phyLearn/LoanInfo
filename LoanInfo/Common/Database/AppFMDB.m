//
//  AppFMDB.m
//  AppFramework
//
//  Created by Penghuaiyu on 16/11/21.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import "AppFMDB.h"
#import "FMDB.h"

#define SQLITE_NAME @"BaseSqlite.sqlite"
static AppFMDB *appFMDB;

@interface AppFMDB()

@property (nonatomic, strong)FMDatabaseQueue *queue;//多线程优化数据库操作

@end
@implementation AppFMDB

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:SQLITE_NAME];//获取存储路径
        self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];//初始化数据库
    }
    return self;
}

/** 获取单例 */
+ (instancetype)intance
{
    if(!appFMDB)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            appFMDB = [[AppFMDB alloc] init];
        });
    }
    return appFMDB;
}

/**
 *  数据库中是否存在表
 */
- (void)isExistWithTableName:(NSString *)name complete:(void(^)(BOOL isExist))complete
{
    if(!name)
    {
        NSLog(@"表名不能为空");
        if(complete)
        {
            complete(NO);
        }
        return;
    }
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        result = [db tableExists:name];
    }];
    if(complete)
    {
        complete(result);
    }
}

/**
 *  建立主键ID
 *
 *  @param name     表名
 *  @param keys     字段名数组
 *  @param complete 回调
 */
- (void)createTableWithTableName:(NSString *)name keys:(NSArray *)keys complete:(void (^)(BOOL isSuccess))complete
{
    if (name == nil) {
        NSLog(@"表名不能为空!");
        if (complete) {
            complete(NO);
        }
        return;
    }else if (keys == nil){
        NSLog(@"字段数组不能为空!");
        if (complete) {
            complete(NO);
        }
        return;
    }else;
    
    //创表
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString* header = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement",name];//,name text,age integer);
        NSMutableString* sql = [[NSMutableString alloc] init];
        [sql appendString:header];
        for(int i=0;i<keys.count;i++){
            [sql appendFormat:@",%@ text",keys[i]];
            if (i == (keys.count-1)) {
                [sql appendString:@");"];
            }
        }
        result = [db executeUpdate:sql];
    }];
    if (complete){
        complete(result);
    }
}

/**
 *  插入数据
 *
 *  @param name     表名
 *  @param dict     需要插入的数据模型
 *  @param complete 查询状态回调
 */
- (void)insertIntoTableName:(NSString *)name Dict:(NSDictionary *)dict complete:(void (^)(BOOL isSuccess))complete
{
    if(name == nil)
    {
        NSLog(@"表名不能为空");
        if(complete)
        {
            complete(NO);
        }
        return;
    }else if (dict == nil)
    {
        NSLog(@"插入值字典不能为空");
        if(complete)
        {
            complete(NO);
        }
        return;
    }else;
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSArray *keys = dict.allKeys;
        NSArray *values = dict.allValues;
        NSMutableString *SQL = [[NSMutableString alloc] init];
        [SQL appendFormat:@"insert into %@(",name];
        for (int i = 0; i < keys.count; i++) {
            [SQL appendFormat:@"%@",keys[i]];
            if(i==(keys.count-1))
            {
                [SQL appendString:@") "];
            }else
            {
                [SQL appendString:@","];
            }
        }
        [SQL appendString:@"values("];
        for (int i = 0; i < values.count; i++) {
            [SQL appendString:@"?"];
            if(i == (keys.count-1))
            {
                [SQL appendString:@");"];
            }else
            {
                [SQL appendString:@","];
            }
        }
        result = [db executeUpdate:SQL withArgumentsInArray:values];
    }];
    if(complete)
    {
        complete(result);
    }
}

/**
 *  条件查询
 *
 *  @param name     表名
 *  @param keys     key值数组
 *  @param where    查找条件数组
 *  @param complete 回调
 */
- (void)queryWithTableName:(NSString *)name keys:(NSArray *)keys where:(NSArray *)where complete:(void (^)(NSArray *array))complete
{
    if(name == nil)
    {
        NSLog(@"表名不能为空");
        if(complete)
        {
            complete(nil);
        }
        return;
    }
    //查询结果
    __block NSMutableArray *arrM = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        NSMutableString *SQL = [[NSMutableString alloc] init];
        [SQL appendString:@"select"];
        if((keys!=nil)&&(keys.count>0))
        {
            [SQL appendString:@" "];
            for(int i = 0; i < keys.count; i++)
            {
                [SQL appendFormat:@"%@",keys[i]];
                if(i != (keys.count - 1))
                {
                    [SQL appendString:@","];
                }
            }
        }else
        {
            [SQL appendString:@" *"];
        }
        [SQL appendFormat:@" from %@",name];
        if((where != nil) && (where.count > 0))
        {
            if(!(where.count % 3))
            {
                [SQL appendString:@" where "];
                for(int i = 0; i < where.count; i+=3)
                {
                    [SQL appendFormat:@"%@%@'%@'",where[i],where[i+1],where[i+2]];
                    if(i != (where.count-3))
                    {
                        [SQL appendString:@" and "];
                    }
                }
            }else
            {
                NSLog(@"条件数组错误");
            }
        }
        //查询数据
        FMResultSet *rs = [db executeQuery:SQL];
        //遍历结果集
        while (rs.next) {
            NSMutableDictionary *dictM = [[NSMutableDictionary alloc] init];
            for(int i = 0; i <[[[rs columnNameToIndexMap] allKeys] count]; i++)// columnNameToIndexMap这个方法使返回一个带索引的字典
            {
                dictM[[rs columnNameForIndex:i]] = [rs objectForColumnIndex:i];
            }
            [arrM addObject:dictM];
        }
    }];
    if(complete)
    {
        complete(arrM);
    }
}

/**
 *  查询所有数据
 *
 *  @param name     表名
 *  @param complete 回调
 */
- (void)queryWithTableName:(NSString *)name complete:(void (^)(NSArray *array))complete
{
    if (name==nil){
        NSLog(@"表名不能为空!");
        if (complete) {
            complete(nil);
        }
        return;
    }
    
    __block NSMutableArray *arrM = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *SQL = [NSString stringWithFormat:@"select * from %@",name];
        //查询数据
        FMResultSet *rs = [db executeQuery:SQL];
        //遍历结果集
        while (rs.next) {
            NSMutableDictionary *dictM = [[NSMutableDictionary alloc] init];
            for (int i=0; i<[[[rs columnNameToIndexMap] allKeys] count]; i++) {
                dictM[[rs columnNameForIndex:i]] = [rs objectForColumnIndex:i];
            }
            [arrM addObject:dictM];
        }
    }];
    if(complete)
    {
        complete(arrM);
    }
}

/**
 *  更新表
 *
 *  @param name      表名
 *  @param valueDict 关键字字典
 *  @param where
 *  @param complete  回调
 */
- (void)updateWithTableName:(NSString *)name valueDict:(NSDictionary *)valueDict where:(NSArray *)where complete:(void(^)(BOOL isSuccess))complete
{
    if (name == nil) {
        NSLog(@"表名不能为空!");
        if (complete) {
            complete(NO);
        }
        return;
    }
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSMutableString *SQL = [[NSMutableString alloc] init];
        [SQL appendFormat:@"update %@ set ",name];
        for(int i = 0; i<valueDict.allKeys.count;i++)
        {
            [SQL appendFormat:@"%@='%@'",valueDict.allKeys[i],valueDict[valueDict.allKeys[i]]];
            if(i != (valueDict.allKeys.count-1))
            {
                [SQL appendString:@","];
            }
        }
        if ((where!=nil) && (where.count>0)){
            if(!(where.count%3)){
                [SQL appendString:@" where "];
                for(int i=0;i<where.count;i+=3){
                    [SQL appendFormat:@"%@%@'%@'",where[i],where[i+1],where[i+2]];
                    if (i != (where.count-3)) {
                        [SQL appendString:@" and "];
                    }
                }
            }else{
                NSLog(@"条件数组格式错误!");
            }
        }
        result = [db executeUpdate:SQL];
    }];
    if (complete) {
        complete(result);
    }
}

/**
 *  条件删除
 *
 *  @param name     表名
 *  @param where    条件
 *  @param complete 回调
 */
- (void)deleteWithTableName:(NSString *)name where:(NSArray *)where complete:(void(^)(BOOL isSuccess))complete
{
    if(name == nil)
    {
        NSLog(@"表名不能为空");
        if(complete)
        {
            complete(NO);
        }
        return;
    }else if (where==nil || (where.count%3))
    {
        NSLog(@"条件数组错误");
        if(complete)
        {
            complete(NO);
        }
        return;
    }else;
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSMutableString *SQL = [[NSMutableString alloc] init];
        [SQL appendFormat:@"delete from %@ where ",name];
        for (int i = 0; i < where.count; i+=3) {
            [SQL appendFormat:@"%@%@'%@'",where[i],where[i+1],where[i+2]];
            if(i != (where.count-3))
            {
                [SQL appendString:@" and "];
            }
        }
        result = [db executeUpdate:SQL];
    }];
    if(complete)
    {
        complete(result);
    }
}

/**
 *  删除表内所有数据
 *
 *  @param name     表名
 *  @param complete 回调
 */
- (void)clearTable:(NSString *)name complete:(void(^)(BOOL isSuccess))complete
{
    if(name==nil)
    {
        NSLog(@"表名不能为空");
        if(complete)
        {
            complete(NO);
        }
        return;
    }
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *SQL = [NSString stringWithFormat:@"delete from %@",name];
        result = [db executeUpdate:SQL];
    }];
    if(complete)
    {
        complete(result);
    }
}

/**
 *  删除表
 *
 *  @param name     表名
 *  @param complete 回调
 */
- (void)dropTable:(NSString *)name complete:(void(^)(BOOL isSuccess))complete
{
    if (name==nil){
        NSLog(@"表名不能为空!");
        if (complete) {
            complete(NO);
        }
        return;
    }
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *SQL = [NSString stringWithFormat:@"drop table %@",name];
        result = [db executeUpdate:SQL];
    }];
    if(complete)
    {
        complete(result);
    }
}

/**
 *  存储一个对象
 *
 *  @param object   需要存储的对象
 *  @param complete 回调
 */
- (void)saveObject:(id)object complete:(void(^)(BOOL isSuccess))complete
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    unsigned int numIvars;
    Ivar *vars = class_copyIvarList([object class], &numIvars);//获取成员变量列表
    NSString *key = nil;
    for (int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];//获取成员变量名字
        key = [key substringFromIndex:1];
        [dictM setObject:[object valueForKey:key] forKey:key];
    }
    free(vars);
    NSString *tableName = [NSString stringWithFormat:@"%@",[object class]];
    [self isExistWithTableName:tableName complete:^(BOOL isExist) {
        if(!isExist)
        {
           [self createTableWithTableName:tableName keys:dictM.allKeys complete:^(BOOL isSuccess) {
               if(isSuccess)
               {
                   NSLog(@"建表成功 第一次建立 %@ 对应的表",tableName);
               }
           }];
        }
    }];
    [self insertIntoTableName:tableName Dict:dictM complete:complete];
}

/**
 *  查询对象
 *
 *  @param cla      需要查询的对象
 *  @param complete 回调
 */
- (void)queryAllObject:(__unsafe_unretained Class)cla complete:(void(^)(NSArray *array))complete
{
    //检查是否建立了跟对象对应的数据表
    NSString *tableName = [NSString stringWithFormat:@"%@",cla];
    [self isExistWithTableName:tableName complete:^(BOOL isExist) {
        if(!isExist)
        {
            if(complete)
            {
                complete(nil);
            }
        }else
        {
            [self queryWithTableName:tableName complete:^(NSArray *array) {
                NSMutableArray *arrM = [NSMutableArray array];
                for(NSDictionary *dict in array)
                {
                    [arrM addObject:dict];
                }
                if(complete)
                {
                    complete(arrM);
                }
            }];
        }
    }];
}

/**
 *   根据条件查询某个对象
 *
 *  @param cla      对象名
 *  @param keys     keys存放的是要查询的哪些key,为nil时代表查询全部
 *  @param where    查找类型
 *  @param complete  where形式 @[@"key",@"=",@"value",@"key",@">=",@"value"]
 */
- (void)queryObjectWithClass:(__unsafe_unretained Class)cla keys:(NSArray *)keys where:(NSArray *)where complete:(void(^)(NSArray *array))complete
{
    NSString *tableName = [NSString stringWithFormat:@"%@",cla];
    [self isExistWithTableName:tableName complete:^(BOOL isExist) {
        if(!isExist)
        {
            if(complete)
            {
                complete(nil);
            }
        }else
        {
            [self queryWithTableName:tableName keys:keys where:where complete:^(NSArray *array) {
                NSMutableArray* arrM = [NSMutableArray array];
                for(NSDictionary* dict in array){
                    [arrM addObject:dict];
                }
                if (complete) {
                    complete(arrM);
                }
            }];
        }
    }];
}
/**
 根据条件改变对象的值
 valueDict 存放的是key和value
 where数组的形式 @[@"key",@"=",@"value",@"key",@">=",@"value"]
 */
-(void)updateWithClass:(__unsafe_unretained Class)cla valueDict:(NSDictionary*)valueDict where:(NSArray*)where complete:(void (^)(BOOL isSuccess))complete{
    NSString* tableName = [NSString stringWithFormat:@"%@",cla];
    [self isExistWithTableName:tableName complete:^(BOOL isExist) {
        if (!isExist){//如果不存在就返回NO
            if (complete) {
                complete(NO);
            }
        }else{
            [self updateWithTableName:tableName valueDict:valueDict where:where complete:complete];
        }
    }];
}
/**
 cla代表对应的类
 根据条件删除对象表中的对象数据
 where形式 @[@"key",@"=",@"value",@"key",@">=",@"value"],where要非空
 */
-(void)deleteWithClass:(__unsafe_unretained Class)cla where:(NSArray*)where complete:(void (^)(BOOL isSuccess))complete{
    NSString* tableName = [NSString stringWithFormat:@"%@",cla];
    [self isExistWithTableName:tableName complete:^(BOOL isExist) {
        if (!isExist){//如果不存在就返回NO
            if (complete) {
                complete(NO);
            }
        }else{
            [self deleteWithTableName:tableName where:where complete:complete];
        }
    }];
    
}
/**
 根据类删除此类所有表数据
 */
-(void)clearWithClass:(__unsafe_unretained Class)cla complete:(void (^)(BOOL isSuccess))complete{
    NSString* tableName = [NSString stringWithFormat:@"%@",cla];
    [self isExistWithTableName:tableName complete:^(BOOL isExist) {
        if (!isExist){//如果不存在就返回NO
            if (complete) {
                complete(NO);
            }
        }else{
            [self clearTable:tableName complete:complete];
        }
    }];
}
/**
 根据类,删除这个类的表
 */
-(void)dropWithClass:(__unsafe_unretained Class)cla complete:(void (^)(BOOL isSuccess))complete{
    NSString* tableName = [NSString stringWithFormat:@"%@",cla];
    [self isExistWithTableName:tableName complete:^(BOOL isExist) {
        if (!isExist){//如果不存在就返回NO
            if (complete) {
                complete(NO);
            }
        }else{
            [self dropTable:tableName complete:complete];
        }
    }];
}

@end
