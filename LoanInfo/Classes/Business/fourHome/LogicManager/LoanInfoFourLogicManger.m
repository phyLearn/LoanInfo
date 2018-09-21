//
//  LoanInfoFourLogicManger.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoFourLogicManger.h"
#import "LoanInfoFourImport.h"

@interface LoanInfoFourLogicManger()

@property (nonatomic, strong) LoanInfoFourMainView *mainView;

@end
@implementation LoanInfoFourLogicManger

+(instancetype)shared{
    static LoanInfoFourLogicManger *logicManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logicManager = [[LoanInfoFourLogicManger alloc] init];
    });
    return logicManager;
}

//注册通知
- (void)registerObserWithDele:(id)delegate{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(tableViewDidClick:) name:@"FourTableViewDidClickObser" object:nil];
#pragma clang diagnostic pop
}

//在控制器初始化整个页面
- (void)startLogicManagerWithViewController:(UIViewController *)vc{
    self.belongVC = vc;
    vc.navigationItem.title = [LoanInfoMainConfig getAppName];
    vc.view.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    self.mainView = [[LoanInfoFourMainView alloc] initWithFrame:CGRectMake(LEFTPACEHEIGHT, 0, AppScreenWidth - 2 * LEFTPACEHEIGHT, AppScreenHeight)];
    [vc.view addSubview:self.mainView];
    [self startRequest];
}

- (void)startRequest{
    [[LoanInfoFoutDataManager shared] getFourCellDataComplete:^(NSDictionary *dict) {
        [self.mainView refreshCellData:dict];
    }];
}

- (void)refreshHeader{
    if(self.mainView){
        [[LoanInfoFoutDataManager shared] getFourHeaderDataComplete:^(NSDictionary *dict) {
            [self.mainView refreshHeaderView:dict];
        }];
    }
}

@end
