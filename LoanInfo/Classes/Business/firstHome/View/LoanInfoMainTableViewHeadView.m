//
//  LoanInfoMainTableViewHeadView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoMainTableViewHeadView.h"

@interface LoanInfoMainTableViewHeadView()

@property (weak, nonatomic) IBOutlet UIView *iconHeaderView;

@end
@implementation LoanInfoMainTableViewHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.iconHeaderView.backgroundColor = [LoanInfoMainConfig getBlueColor];
}
@end
