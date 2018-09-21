//
//  LoanInfoFirstLogicManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoFirstLogicManager.h"

@interface LoanInfoMainLogicManager()


@end
@implementation LoanInfoFirstLogicManager

+(instancetype)shared{
    static LoanInfoFirstLogicManager *logicManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logicManager = [[LoanInfoFirstLogicManager alloc] init];
    });
    return logicManager;
}

//在控制器初始化整个页面
- (void)startLogicManagerWithViewController:(UIViewController *)vc{
    self.belongVC = vc;
    vc.navigationItem.title = [LoanInfoMainConfig getAppName];
    vc.view.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    self.firstMainView = [[LoanInfoFirstMainView alloc] initWithFrame:CGRectMake(LEFTPACEHEIGHT, 0, AppScreenWidth - 2 * LEFTPACEHEIGHT, AppScreenHeight - kTabBarHeight)];
    [vc.view addSubview:self.firstMainView];
    [self startRequestData];
}
//刷新数据
- (void)startRequestData{
    //得到banner数据
    [[LoanInfoFirstDataManager shared] getBannerDataComplete:^(NSDictionary *dict) {
        [self.firstMainView refreshBannerViewWithData:dict];
    }];
    
    [[LoanInfoFirstDataManager shared] getMaxLoanCountComplete:^(NSDictionary *dict) {
        [self.firstMainView refreshMaxLoanViewWithData:dict];
    }];
    
    [[LoanInfoFirstDataManager shared] getCellDataComplete:^(NSDictionary *dict) {
        [self.firstMainView refresCellDataWithDict:dict];
    }];
}

//注册通知
- (void)registerObserWithDele:(id)delegate{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(tableViewDidClick:) name:@"tableViewDidClickObser" object:nil];
#pragma clang diagnostic pop
}

@end
