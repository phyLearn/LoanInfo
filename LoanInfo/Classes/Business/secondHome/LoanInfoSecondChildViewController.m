//
//  LoanInfoSecondChildViewController.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/11.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoSecondChildViewController.h"
#import "LoanInfoSecondImport.h"

@interface LoanInfoSecondChildViewController ()

@property (nonatomic, assign) NSUInteger page;
@end

@implementation LoanInfoSecondChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [[LoanInfoSecondLogicManager shared] startLogicManagerWithViewController:self paramDict:_paramDict];
}

- (void)setTag:(NSInteger)tag{
    self.view.tag = tag;
     [[LoanInfoSecondLogicManager shared] removeAllObserWithDele:self];
    [[LoanInfoSecondLogicManager shared] registerObserChildDele:self withTag:self.view.tag];
}

//下拉刷新
- (void)headerRefresh{
    LoanInfoSecondMainView *mainView = [self.view viewWithTag:CHILDMAINVIEWTAG];
    [[LoanInfoSecondLogicManager shared] startRequestWithType:[self getCurrentType] page:@"1" mainView:mainView];
}

//上拉刷新
- (void)footerRefresh{
    self.page++;
    LoanInfoSecondMainView *mainView = [self.view viewWithTag:CHILDMAINVIEWTAG];
    [[LoanInfoSecondLogicManager shared] startRequestWithType:[self getCurrentType] page:[NSString stringWithFormat:@"%ld",self.page] mainView:mainView];
}

- (NSString *)getCurrentType{
    NSInteger currentIndex = self.view.tag;
    NSString *type = [NSString string];
    switch (currentIndex) {
        case 20:
        {
            type = @"2";
        }
            break;
        case 21:
        {
            type = @"2";
        }
            break;
        case 22:
        {
            type = @"3";
        }
            break;
        case 23:
        {
            type = @"4";
        }
            break;
        default:
            break;
    }
    return type;
}

- (void)dealloc{
    [[LoanInfoSecondLogicManager shared] removeAllObserWithDele:self];
}
@end
