//
//  LoanInfoProductsCell.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoProductsCell.h"

@interface LoanInfoProductsCell()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *backMainView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
@implementation LoanInfoProductsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backMainView.layer.cornerRadius = 5;
    self.bottomView.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
}

- (void)refreshUI:(NSDictionary *)dict{
    self.titleLabel.text = dict[@"cellTitle"];
    self.contentLabel.text = dict[@"cellContent"];
}
@end
