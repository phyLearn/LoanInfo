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
    self.titleLabel.text = dict[@"title"];
    if(dict[@"aDesc"]){
        self.aDescLabel.text = dict[@"aDesc"];
        self.aDescLabel.hidden = NO;
    }else{
        self.aDescLabel.hidden = YES;
    }
    self.maxLabel.text = dict[@"maxMoney"];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"imageUrl"]]];
}

@end
