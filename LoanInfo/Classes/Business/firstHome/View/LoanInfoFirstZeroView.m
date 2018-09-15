//
//  LoanInfoFirstZeroView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/10.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoFirstZeroView.h"

@interface LoanInfoFirstZeroView()

@property (weak, nonatomic) IBOutlet UILabel *bottomDescLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
@property (weak, nonatomic) IBOutlet UILabel *headerDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
@implementation LoanInfoFirstZeroView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lookBtn.backgroundColor = [LoanInfoMainConfig getYellowColor];
    self.lookBtn.layer.cornerRadius = self.lookBtn.frame.size.width / 20;
    self.lookBtn.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneAction)];
    [self addGestureRecognizer:tapOne];
}

- (void)tapOneAction{
    if(self.tapOneActionBlock)
        self.tapOneActionBlock();
}

- (void)refreshUI:(NSDictionary *)dict{
    self.headerDescLabel.text = dict[@"headerDesc"];
    self.bottomDescLabel.text = dict[@"bottomDesc"];
    self.moneyLabel.text = dict[@"money"];
}

@end
