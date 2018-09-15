//
//  LoanInfoFirstMainView.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanInfoFirstMainView : UIView

- (void)refreshBannerViewWithData:(NSDictionary *)dict;

- (void)refreshMaxLoanViewWithData:(NSDictionary *)dict;

//刷新table
- (void)refresCellDataWithDict:(NSDictionary *)dict;
@end
