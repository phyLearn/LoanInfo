//
//  appRoute+LoanInfoProductsRout.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "appRoute+LoanInfoProductsRout.h"

@implementation AppRoute (LoanInfoProductsRout)

+ (void)routeToProductsVC:(UIViewController *)VC{
    LoanInfoProducesViewController *pruductVC =[[LoanInfoProducesViewController alloc] init];
    [VC.navigationController pushViewController:pruductVC animated:YES];
}
@end
