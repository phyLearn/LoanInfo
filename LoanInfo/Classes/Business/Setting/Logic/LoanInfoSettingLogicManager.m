//
//  LoanInfoSettingLogicManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/12.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoSettingLogicManager.h"
#import "LoanInfoSettingImport.h"

@implementation LoanInfoSettingLogicManager

+(instancetype)shared{
    static LoanInfoSettingLogicManager *logicManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logicManager = [[LoanInfoSettingLogicManager alloc] init];
    });
    return logicManager;
}

//在控制器初始化整个页面
- (void)startLogicManagerWithViewController:(UIViewController *)vc{
    self.belongVC = vc;
    vc.navigationItem.title = [LoanInfoMainConfig getAppName];
    
    LoanInfoSettingMainView *settingView = [[NSBundle mainBundle] loadNibNamed:@"LoanInfoSettingMainView" owner:self options:0][0];
    settingView.frame = CGRectMake(0, kNavigationBarHeight, AppScreenWidth, AppScreenHeight - kNavigationBarHeight);
    [vc.view addSubview:settingView];
    settingView.quiteLoginBtnAction = ^{
        [self quitLogin];
    };
}

- (void)quitLogin{
    [[LoanInfoLoginLogicManager shared] quitLoginComplete:^{
        //跳转登录
        [AppRoute loginComplete:nil];
    }];
}

@end
