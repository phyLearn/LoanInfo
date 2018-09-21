//
//  LoanInfoSecondLogicManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoSecondLogicManager.h"

@interface LoanInfoSecondLogicManager()

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
- (void)startLogicManagerWithViewController:(UIViewController *)vc paramDict:(NSDictionary *)paramDict{
    self.belongVC = vc;
    vc.view.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    LoanInfoSecondMainView *mainView = [[LoanInfoSecondMainView alloc] initWithFrame:CGRectMake(LEFTPACEHEIGHT, 0, AppScreenWidth - 2 * LEFTPACEHEIGHT, AppScreenHeight - kTabBarHeight - kNavigationBarHeight - 44 - SPACEHEIGHT)]; //44是上面titleView的高度
    mainView.tag = CHILDMAINVIEWTAG;
    [vc.view addSubview:mainView];
}

- (void)startLogicManagerWithSecondViewController:(UIViewController *)vc{
    vc.navigationItem.title = [LoanInfoMainConfig getAppName];
    LoanInfoSecondFatherView *fatherView = [[LoanInfoSecondFatherView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, AppScreenWidth, AppScreenHeight) withDele:vc];
    [vc.view addSubview:fatherView];
}

- (void)startRequestWithType:(NSString *)type page:(NSString *)page mainView:(LoanInfoSecondMainView *)mainView{
    [[LoanInfoSecondDataManager shared] getCellDataWithType:type num:@"10" page:page Complete:^(NSDictionary *dict, NSString *inpage) {
        [mainView refresCellDataWithDict:dict page:page];
    }];
}

//注册通知
- (void)registerObserWithDele:(id)delegate{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(tableViewDidClick:) name:@"secondTableViewDidClickObser" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(scrollViewMove:) name:@"scrollViewMoveObser" object:nil];
#pragma clang diagnostic pop
}

- (void)registerObserChildDele:(id)delegate withTag:(NSInteger)tag{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(headerRefresh) name:[NSString stringWithFormat:@"%@%ld",@"headerRefreshObser",tag] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(footerRefresh) name:[NSString stringWithFormat:@"%@%ld",@"footerRefreshObser",tag] object:nil];
#pragma clang diagnostic pop
}

@end
