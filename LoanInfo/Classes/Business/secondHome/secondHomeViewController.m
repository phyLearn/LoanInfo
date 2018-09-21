//
//  secondHomeViewController.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/6/29.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "secondHomeViewController.h"
#import "LoanInfoSecondImport.h"

@interface secondHomeViewController ()

@property (nonatomic, assign) NSInteger centerIndex;

@end

@implementation secondHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[LoanInfoSecondLogicManager shared] startLogicManagerWithSecondViewController:self];
    [[LoanInfoSecondLogicManager shared] registerObserWithDele:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [LoanInfoTools interactivePopGestureRecognizerEnable:NO controllerView:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [LoanInfoTools interactivePopGestureRecognizerEnable:YES controllerView:self];
}

- (void)tableViewDidClick:(NSNotification *)noti{
    HYLog(@"tableViewDidClick");
    NSDictionary *infoDict = noti.object;
    [AppRoute routeToProductsVC:self paramDict:infoDict];
}

- (void)scrollViewMove:(NSNotification *)noti{
    NSDictionary *infoDict = noti.object;
    NSInteger index = [infoDict[@"index"] integerValue];
    self.centerIndex = index;
    [self startRequestWithIndex:index page:@"1"];
}

- (void)startRequestWithIndex:(NSInteger)index page:(NSString *)page{
    LoanInfoSecondChildViewController *childViewController = self.childViewControllers[index];
    childViewController.tag = 20 + index;
    LoanInfoSecondMainView *mainView = [childViewController.view viewWithTag:CHILDMAINVIEWTAG];
    mainView.currentTag = 20 + index;
    NSString *type = [NSString string];
    switch (index) {
        case 0:
        {
            type = @"2";
        }
            break;
        case 1:
        {
            type = @"2";
        }
            break;
        case 2:
        {
            type = @"3";
        }
            break;
        case 3:
        {
            type = @"4";
        }
            break;
        default:
            break;
    }
    [[LoanInfoSecondLogicManager shared] startRequestWithType:type page:page mainView:mainView];
}

- (void)dealloc{
    [[LoanInfoSecondLogicManager shared] removeAllObserWithDele:self];
}

@end
