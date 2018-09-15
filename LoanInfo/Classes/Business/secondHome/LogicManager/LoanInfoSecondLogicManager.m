//
//  LoanInfoSecondLogicManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoSecondLogicManager.h"
#import "LoanInfoSecondImport.h"

@interface LoanInfoSecondLogicManager()

@property (nonatomic, strong) LoanInfoSecondMainView *mainView;

@end
@implementation LoanInfoSecondLogicManager

+(instancetype)shared{
    static LoanInfoSecondLogicManager *logicManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logicManager = [[LoanInfoSecondLogicManager alloc] init];
    });
    return logicManager;
}

//在控制器初始化整个页面
- (void)startLogicManagerWithViewController:(UIViewController *)vc{
    self.belongVC = vc;
    vc.view.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    self.mainView = [[LoanInfoSecondMainView alloc] initWithFrame:CGRectMake(LEFTPACEHEIGHT, 0, AppScreenWidth - 2 * LEFTPACEHEIGHT, AppScreenHeight - kTabBarHeight - kNavigationBarHeight - 44 - SPACEHEIGHT)]; //44是上面titleView的高度
    [vc.view addSubview:self.mainView];
    [self startRequest];
}

- (void)startLogicManagerWithSecondViewController:(UIViewController *)vc{
    vc.navigationItem.title = [LoanInfoMainConfig getAppName];
    LoanInfoSecondFatherView *fatherView = [[LoanInfoSecondFatherView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, AppScreenWidth, AppScreenHeight) withDele:vc];
    [vc.view addSubview:fatherView];
}

- (void)startRequest{
    //得到banner数据    
    [[LoanInfoSecondDataManager shared] getCellDataComplete:^(NSDictionary *dict) {
        [self.mainView refresCellDataWithDict:dict];
    }];
}

//注册通知
- (void)registerObserWithDele:(id)delegate{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(tableViewDidClick) name:@"secondTableViewDidClickObser" object:nil];
#pragma clang diagnostic pop
}

@end
