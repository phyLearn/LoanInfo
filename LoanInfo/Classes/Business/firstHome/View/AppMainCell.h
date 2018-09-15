//
//  AppMainCell.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/3.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cellActionBlock)(void);

@interface AppMainCell : UITableViewCell

@property (nonatomic, copy) cellActionBlock cellActionBlock;

//刷新数据
- (void)refreshUI:(NSDictionary *)dict;

@end
