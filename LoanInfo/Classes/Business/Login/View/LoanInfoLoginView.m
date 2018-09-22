//
//  LoanInfoLoginView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoLoginView.h"
#import "LoanInfoLoginImport.h"
#import "GBverifyButton.h"

@interface LoanInfoLoginView()
<
    UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UIView *mobileBackView;
@property (weak, nonatomic) IBOutlet UIView *smsBackView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileDescLabel;
@property (weak, nonatomic) IBOutlet UIButton *xieyiBtn;
@property (weak, nonatomic) IBOutlet UILabel *xieyiDescLabel;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *smsTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong, nonatomic) GBverifyButton *smsBtn;
@property (weak, nonatomic) IBOutlet UIView *smsBtnBackView;

@end
@implementation LoanInfoLoginView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.descLabel.textColor = [LoanInfoMainConfig getYellowColor];
    self.mobileDescLabel.textColor = [LoanInfoMainConfig getYellowColor];
    self.xieyiDescLabel.textColor = [LoanInfoMainConfig getLighGrayColor];
    self.loginBtn.backgroundColor = [LoanInfoMainConfig getLighGrayColor];
    self.loginBtn.userInteractionEnabled = NO;//初始不能被点击
    [self.smsBtnBackView addSubview:self.smsBtn];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"我已同意并阅读《用户服务协议》"];
    [attrStr setAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}
                     range:NSMakeRange(7, 8)];
    self.xieyiDescLabel.attributedText = attrStr;
    
    //需要监听Textfield的变化
    [self.mobileTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.smsTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.mobileTextField.delegate = self;
    self.smsTextField.delegate = self;
}

- (GBverifyButton *)smsBtn{
    if(!_smsBtn){
        _smsBtn = [[GBverifyButton alloc] initWithFrame:self.smsBtnBackView.bounds delegate:self.smsBtnBackView Target:self Action:@selector(smsBtnAction:)];
        [_smsBtn setTitleFont:[UIFont systemFontOfSize:14]];
        [_smsBtn setTitleColor:[LoanInfoMainConfig getYellowColor] forState:UIControlStateNormal];
        [_smsBtn setBackgroundColor:[UIColor whiteColor]];
    }
    return _smsBtn;
}

//登录按钮点击
- (IBAction)loginBtnAction:(UIButton *)sender {
    NSMutableDictionary *loginInfo = [NSMutableDictionary dictionary];
    [loginInfo setValue:self.mobileTextField.text ? self.mobileTextField.text : @"" forKey:@"mobile"];
    [loginInfo setValue:self.smsTextField.text ? self.smsTextField.text : @"" forKey:@"smsCode"];
    
    if(self.loginBtnClick)
        self.loginBtnClick([loginInfo copy]);
}

- (void)smsBtnAction:(UIButton *)sender{
    
    if(self.mobileTextField.text.length > 0){
        //展示倒计时
        [self.smsBtn startGetMessage];
    }
    if(self.smsBtnClick)
        self.smsBtnClick(self.mobileTextField.text);
}
- (IBAction)xieyibtnAction:(UIButton *)sender {
    self.xieyiBtn.selected = !self.xieyiBtn.selected;
}

- (IBAction)quiteBtnAction:(UIButton *)sender{
    if(self.quiteBtnClick)
        self.quiteBtnClick();
}

//监听textfield的变化
- (void)textFieldDidChange:(UITextField *)textfield{
    UITextField *mobileTextfield = [self viewWithTag:30];//手机号输入框
    UITextField *smsTextfield = [self viewWithTag:31];//验证码输入框
    if(mobileTextfield.text.length > 0 && smsTextfield.text.length > 0){
        self.loginBtn.userInteractionEnabled = YES;
        self.loginBtn.backgroundColor = [LoanInfoMainConfig getYellowColor];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSUInteger length = textField.text.length - range.length + string.length;
    if(30 == textField.tag){
        if(length> 11){
            return NO;
        }
    }
    
    if(31 == textField.tag){
        if(length > 6){
            return NO;
        }
    }
    return YES;
}

@end
