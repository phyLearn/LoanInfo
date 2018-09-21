//
//  AppMainCell.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/3.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "AppMainCell.h"

@interface AppMainCell()

@property (weak, nonatomic) IBOutlet UILabel *aDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *loansCountLabel;

@end
@implementation AppMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneAction)];
    [self addGestureRecognizer:tapOne];
    
    self.maxLabel.textColor = [LoanInfoMainConfig getYellowColor];
}

- (void)tapOneAction{
    if(self.cellActionBlock)
        self.cellActionBlock();
}

- (void)refreshUI:(NSDictionary *)dict{
    self.titleLabel.text = dict[@"name"];
    if(dict[@"feat"]){
        self.aDescLabel.text = dict[@"feat"];
        self.aDescLabel.hidden = NO;
    }else{
        self.aDescLabel.hidden = YES;
    }
    self.maxLabel.text = [NSString stringWithFormat:@"%@-%@",dict[@"max"],dict[@"min"]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"logo"]]];
    self.loansCountLabel.text = [NSString stringWithFormat:@"%@已放款",dict[@"loans"]];
}

@end
