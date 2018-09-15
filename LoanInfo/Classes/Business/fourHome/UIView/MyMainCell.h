//
//  MyMainCell.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/4.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cellClickBlock)(void);

@interface MyMainCell : UITableViewCell

@property (nonatomic, copy) cellClickBlock cellClickBlock;

//刷新数据
- (void)refreshUI:(NSDictionary *)dict;

@end
