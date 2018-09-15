//
//  LoanInfoProductsMainView.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^nextBtnActionBlock)(void);

@interface LoanInfoProductsMainView : UIView

@property (nonatomic, copy) nextBtnActionBlock nextBtnActionBlock;

//用于存储数据
@property (nonatomic, strong) NSDictionary *productsData;

@end