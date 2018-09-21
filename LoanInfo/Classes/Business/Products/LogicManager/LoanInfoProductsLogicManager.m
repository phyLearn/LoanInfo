//
//  LoanInfoProductsLogicManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoProductsLogicManager.h"
#import "LoanInfoProductsImport.h"

@interface LoanInfoProductsLogicManager()

@property (nonatomic, strong) NSDictionary *webResponseData;
@property (nonatomic, strong) LoanInfoProductsMainView *productsView;

@end
@implementation LoanInfoProductsLogicManager

+(instancetype)shared{
    static LoanInfoProductsLogicManager *logicManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logicManager = [[LoanInfoProductsLogicManager alloc] init];
    });
    return logicManager;
}

//在控制器初始化整个页面
- (void)startLogicManagerWithViewController:(UIViewController *)vc paramDict:(NSDictionary *)paramDict complete:(void(^)(completeEnum sonCompleteEnum,NSDictionary *responseDict))complete{
    self.belongVC = vc;
    vc.view.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    vc.title = @"产品详情";
    self.productsView = [[LoanInfoProductsMainView alloc] initWithFrame:CGRectMake(LEFTPACEHEIGHT, 0, AppScreenWidth - 2 * LEFTPACEHEIGHT, AppScreenHeight)];
    //请求数据
    [self getProductsResponseDataWithDict:paramDict];
    @weakify(self);
    self.productsView.nextBtnActionBlock = ^{
        HYLog(@"立即借款点击");
        if(complete)
            complete(nextBtnEnum,weak_self.webResponseData);
    };
    [vc.view addSubview:self.productsView];
}

- (void)getProductsResponseDataWithDict:(NSDictionary *)paramDict{
    
    [[LoanInfoProductsDataManager shared] getProdictsResponseData:paramDict[@"listId"] complete:^(NSDictionary *dict) {
        self.webResponseData = dict;
        self.productsView.productsData = dict;
    }];
}

@end
