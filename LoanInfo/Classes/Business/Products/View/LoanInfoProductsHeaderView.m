//
//  LoanInfoProductsHeaderView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoProductsHeaderView.h"

@interface LoanInfoProductsHeaderView()
@property (weak, nonatomic) IBOutlet UIView *backMainView;
@property (weak, nonatomic) IBOutlet UIView *headerBackView;
@property (weak, nonatomic) IBOutlet UIView *contentMainView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *gateLabel;

@end
@implementation LoanInfoProductsHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
    self.backMainView.backgroundColor = [LoanInfoMainConfig getYellowColor];
    self.headerBackView.backgroundColor = [LoanInfoMainConfig getBlueColor];
    self.headerBackView.backgroundColor = [LoanInfoMainConfig getYellowColor];
    self.contentMainView.backgroundColor = [LoanInfoMainConfig getYellowColor];
}

- (void)refreshUI:(NSDictionary *)dict{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"productsImage"]]];
    self.titleLabel.text = dict[@"productsTitle"];
    self.peopleLabel.text = dict[@"productsPeople"];
    self.moneyLabel.text = dict[@"productsMoney"];
    self.timeLabel.text = dict[@"productsTime"];
    self.gateLabel.text = dict[@"productsGate"];
}
@end
