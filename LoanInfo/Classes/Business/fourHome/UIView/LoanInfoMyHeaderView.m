//
//  LoanInfoMyHeaderView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/11.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoMyHeaderView.h"

@interface LoanInfoMyHeaderView()
@property (weak, nonatomic) IBOutlet UIView *backMainView;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@end
@implementation LoanInfoMyHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backMainView.backgroundColor = [LoanInfoMainConfig getYellowColor];
    self.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
}
@end
