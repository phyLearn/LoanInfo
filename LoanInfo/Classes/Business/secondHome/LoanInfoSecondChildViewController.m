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

@end

@implementation LoanInfoSecondChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LoanInfoSecondLogicManager shared] startLogicManagerWithViewController:self];
}

@end
