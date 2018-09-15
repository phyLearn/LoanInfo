//
//  LoanInfoSettingViewController.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoSettingViewController.h"
#import "LoanInfoSettingImport.h"

@interface LoanInfoSettingViewController ()

@end

@implementation LoanInfoSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    [[LoanInfoSettingLogicManager shared] startLogicManagerWithViewController:self];
}

@end
