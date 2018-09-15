//
//  MyMainCell.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/4.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "MyMainCell.h"

@interface MyMainCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end
@implementation MyMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneAction)];
    [self addGestureRecognizer:tapOne];
}

- (void)tapOneAction{
    if(self.cellClickBlock)
        self.cellClickBlock();
}

- (void)refreshUI:(NSDictionary *)dict{
    self.titleLabel.text = dict[@"title"];
    [self.iconImageView setImage:[UIImage imageNamed:dict[@"imageName"]]];
}
@end
