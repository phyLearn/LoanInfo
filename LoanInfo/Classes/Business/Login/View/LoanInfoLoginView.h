//
//  LoanInfoLoginView.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

//登录点击
typedef void (^loginBtnClick)(NSDictionary *loginInfo);
//放弃登录,直接返回首页
typedef void (^quiteBtnClick)(void);
//发送短信
typedef void (^smsBtnClick)(NSString *phone);

@interface LoanInfoLoginView : UIView

@property (nonatomic, copy) loginBtnClick loginBtnClick;
@property (nonatomic, copy) quiteBtnClick quiteBtnClick;
@property (nonatomic, copy) smsBtnClick smsBtnClick;
@end
