//
//  LoanInfoMainLogicManager.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanInfoMainLogicManager : NSObject

//所属控制器
@property (nonatomic, strong) UIViewController *belongVC;

//新建对象
+(instancetype)shared;

//开始方法
- (void)startLogicManagerWithViewController:(UIViewController *)vc;

//注册通知
- (void)registerObserWithDele:(id)delegate;

//删除通知
- (void)removeAllObserWithDele:(id)delegate;

@end
