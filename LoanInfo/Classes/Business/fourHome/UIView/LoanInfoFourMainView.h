//
//  LoanInfoFourMainView.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanInfoFourMainView : UIView

//刷新cell数据
- (void)refreshCellData:(NSDictionary *)dict;

//刷新header数据
- (void)refreshHeaderView:(NSDictionary *)dict;

@end
