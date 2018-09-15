//
//  LoanInfoSettingMainView.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/12.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^quitLoginBtnAction)(void);

@interface LoanInfoSettingMainView : UIView

@property (nonatomic, copy) quitLoginBtnAction quiteLoginBtnAction;
@end
