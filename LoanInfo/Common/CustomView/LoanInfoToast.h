//
//  LoanInfoToast.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FFToast/FFToast.h>

@interface LoanInfoToast : UIView

+(instancetype)shared;

/**
 创建并显示一个Toast
 @param message 消息内容
 @param duration 显示时长
 */
+ (void)showToastWithMessage:(NSString *)message duration:(NSTimeInterval)duration;

//创建一个加载指示器
- (void)showHUD;

//隐藏加载指示器
- (void)hideHUD;
@end
