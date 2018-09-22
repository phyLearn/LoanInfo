//
//  LoanInfoToast.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoToast.h"
#import "MBProgressHUD.h"

@interface LoanInfoToast()

@property (nonatomic, strong) MBProgressHUD *hud;

@end
@implementation LoanInfoToast

+(instancetype)shared{
    static LoanInfoToast *toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[LoanInfoToast alloc] init];
    });
    return toast;
}

+ (void)showToastWithMessage:(NSString *)message duration:(NSTimeInterval)duration{
    FFToast *toast = [[FFToast alloc]initToastWithTitle:nil message:message iconImage:nil];
    toast.duration = duration;
    toast.toastPosition =  FFToastPositionBottomWithFillet;
    toast.toastBackgroundColor = [UIColor colorWithRed:75.f/255.f green:75.f/255.f blue:75.f/255.f alpha:1.f];
    [toast show:^{
        //点击消息通知时调用
    }];//[toast show];
}

- (void)showHUD{
    //设置菊花颜色
    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor whiteColor];
    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    //设置指示框背景颜色
    self.hud.bezelView.backgroundColor = [UIColor blackColor];
    // 隐藏时候从父控件中移除
    self.hud.removeFromSuperViewOnHide = YES;
}

- (void)hideHUD{
    [self.hud hideAnimated:YES];
}
@end
