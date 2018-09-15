//
//  LoanInfoLoginView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoLoginView.h"
#import "LoanInfoLoginImport.h"

@interface LoanInfoLoginView()

@property (weak, nonatomic) IBOutlet UIView *mobileBackView;
@property (weak, nonatomic) IBOutlet UIView *smsBackView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileDescLabel;
@property (weak, nonatomic) IBOutlet UIButton *xieyiBtn;
@property (weak, nonatomic) IBOutlet UILabel *xieyiDescLabel;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *smsTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *smsBtn;

@end
@implementation LoanInfoLoginView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.descLabel.textColor = [LoanInfoMainConfig getYellowColor];
    self.mobileDescLabel.textColor = [LoanInfoMainConfig getYellowColor];
    self.xieyiDescLabel.textColor = [LoanInfoMainConfig getYellowColor];
    [self.smsBtn setTitleColor:[LoanInfoMainConfig getYellowColor] forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [LoanInfoMainConfig getYellowColor];
}

//登录按钮点击
- (IBAction)loginBtnAction:(UIButton *)sender {
    NSMutableDictionary *loginInfo = [NSMutableDictionary dictionary];
    [loginInfo setValue:self.mobileTextField.text ? self.mobileTextField.text : @"" forKey:@"mobile"];
    
    if(self.loginBtnClick)
        self.loginBtnClick([loginInfo copy]);
}

- (IBAction)smsBtnAction:(UIButton *)sender{
}

- (IBAction)quiteBtnAction:(UIButton *)sender{
    if(self.quiteBtnClick)
        self.quiteBtnClick();
}

@end
