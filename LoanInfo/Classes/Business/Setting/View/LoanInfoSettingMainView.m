//
//  LoanInfoSettingMainView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/12.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoSettingMainView.h"

@interface LoanInfoSettingMainView()

@property (weak, nonatomic) IBOutlet UIView *checkUpdateView;
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;

@end
@implementation LoanInfoSettingMainView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapResture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkUpdateAction)];
    [self addGestureRecognizer:tapResture];
    
    self.quitBtn.layer.cornerRadius = 2;
}

//检查更新
- (void)checkUpdateAction{
    HYLog(@"没有更新");
}

//退出登录
- (IBAction)quitLoginAction:(UIButton *)sender {
    if(self.quiteLoginBtnAction)
        self.quiteLoginBtnAction();
}

@end
