//
//  LoanInfoSecondLogicManager.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoMainLogicManager.h"
#import "LoanInfoSecondImport.h"

@interface LoanInfoSecondLogicManager : LoanInfoMainLogicManager

- (void)registerObserChildDele:(id)delegate withTag:(NSInteger)tag;

- (void)startLogicManagerWithViewController:(UIViewController *)vc paramDict:(NSDictionary *)paramDict;
- (void)startLogicManagerWithSecondViewController:(UIViewController *)vc;

//请求数据
- (void)startRequestWithType:(NSString *)type page:(NSString *)page mainView:(LoanInfoSecondMainView *)mainView;
@end
