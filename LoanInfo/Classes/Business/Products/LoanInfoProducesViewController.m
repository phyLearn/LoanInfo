//
//  LoanInfoProducesViewController.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoProducesViewController.h"
#import "LoanInfoProductsImport.h"

@interface LoanInfoProducesViewController ()

@end

@implementation LoanInfoProducesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LoanInfoProductsLogicManager shared] startLogicManagerWithViewController:self complete:^(completeEnum sonCompleteEnum,NSDictionary *responseDict) {
        switch (sonCompleteEnum) {
            case nextBtnEnum:
                {
                    [self nextBtnActionWithData:responseDict];
                }
                break;
                
            default:
                break;
        }
    }];
}

//立即借款按钮点击
- (void)nextBtnActionWithData:(NSDictionary *)dict{
    [AppRoute routeToWebView:self responseData:dict];
}

@end
