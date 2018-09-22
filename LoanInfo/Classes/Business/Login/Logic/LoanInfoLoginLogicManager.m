//
//  LoanInfoLoginLogicManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoLoginLogicManager.h"
#import "LoanInfoLoginImport.h"

@implementation LoanInfoLoginLogicManager

+(instancetype)shared{
    static LoanInfoLoginLogicManager *logicManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logicManager = [[LoanInfoLoginLogicManager alloc] init];
    });
    return logicManager;
}

//在控制器初始化整个页面
- (void)startLogicManagerWithViewController:(UIViewController *)vc{
    self.belongVC = vc;
    LoanInfoLoginView *loginView = [[NSBundle mainBundle] loadNibNamed:@"LoanInfoLoginView" owner:self options:0][0];
    loginView.frame = vc.view.frame;
    [vc.view addSubview:loginView];
    
    //点击登录
    loginView.loginBtnClick = ^(NSDictionary *loginInfo){
        [[LoanInfoLoginDataManager shared] loginWithPhone:loginInfo[@"mobile"] code:loginInfo[@"smsCode"] complete:^(BOOL isSuccess, NSString *msg) {
            if(isSuccess){
                [self loginBtnActionWithInfo:loginInfo];
            }else{
                [LoanInfoToast showToastWithMessage:msg duration:2.0];
            }
        }];
    };
    
    //发送短信
    loginView.smsBtnClick = ^(NSString *phone) {
        if(phone && ![phone isEqualToString:@""]){
            [[LoanInfoLoginDataManager shared] sendSmsWithPhone:phone];
        }else{
            [LoanInfoToast showToastWithMessage:@"请输入11位手机号" duration:2.0];
        }
    };
    
    loginView.quiteBtnClick = ^{
        [self quiteBtnAction];
    };
}

//注册通知
- (void)registerObserWithDele:(id)delegate{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(loginNextBtnAction) name:@"LoginNextBtnObser" object:nil];
#pragma clang diagnostic pop
}

- (void)loginBtnActionWithInfo:(NSDictionary *)loginInfo{
    //将登录信息存储下来,可以以后做缓存登录，或者判断登录状态
    [AppDatabase saveUserLoginInfo:loginInfo];
    [self.belongVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)quiteBtnAction{
    [self.belongVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)quitLoginComplete:(void(^)(void))complete{
    [AppDatabase removeUserLoginInfoComplete:^(BOOL isSuccess) {
        if(complete){
            complete();//退出成功
        }
    }];
}

@end
