//
//  LoanInfoFirstZeroView.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/10.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapOneActionBlock)(void);

@interface LoanInfoFirstZeroView : UIView

@property (nonatomic, copy) tapOneActionBlock tapOneActionBlock;

- (void)refreshUI:(NSDictionary *)dict;

@end
