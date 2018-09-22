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
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
@implementation LoanInfoMyHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backMainView.backgroundColor = [LoanInfoMainConfig getYellowColor];
    self.backgroundColor = [LoanInfoMainConfig getBackgroundColor];
}

- (IBAction)loginBtnAction:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginBtnClickObser" object:nil];
}

- (void)refreshUI:(NSDictionary *)dict{
    if(!dict[@"mobileText"]){
        self.levelLabel.hidden = YES;
        //需要提示登录
        self.loginBtn.hidden = NO;
    }else{
        self.loginBtn.hidden = YES;
        self.levelLabel.hidden = NO;
        self.mobileLabel.text = dict[@"mobileText"];
    }
}
@end
