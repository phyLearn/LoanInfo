//
//  AppRoute.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/4.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "AppRoute.h"

@implementation AppRoute

+ (void)loginComplete:(void(^)(void))complete{
    //判断是否登录，没有登录则需要跳转
    [AppDatabase islogin:^(BOOL isLogin) {
        if(isLogin){
            if(complete)
                complete();
            return;
        }
        //没有登录直接跳转登录页
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [[self getHomeController] presentViewController:loginVC animated:YES completion:nil];
    }];
}

//跳转之前需要先判断是否在首页，如果不是首页需要找到首页进行跳转，所以返回也是首页，代表着登录的唯一入口就是首页，这就是强制登录
+ (UIViewController *)getHomeController{
    //获取当前控制器
    UIViewController *currentVC = [LoanInfoTools getCurrentVC];
    //需要跳到首页
    if([currentVC.tabBarController selectedIndex] != 0){
        currentVC.tabBarController.selectedIndex = 0;
    }
    
    //出栈
    if(currentVC.navigationController.childViewControllers.count > 1){
        [currentVC.navigationController popToRootViewControllerAnimated:YES];
    }
    
    UIViewController *homeVC = [LoanInfoTools getCurrentVC];
    return homeVC;
}

@end
