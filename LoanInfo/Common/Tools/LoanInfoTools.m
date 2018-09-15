//
//  LoanInfoTools.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/12.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoTools.h"

@implementation LoanInfoTools

+  (UIViewController *)getCurrentVC {
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+ (void)interactivePopGestureRecognizerEnable:(BOOL)isEnable controllerView:(UIViewController *)vc{
    if([vc.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        vc.navigationController.interactivePopGestureRecognizer.enabled = isEnable;
    }
}

+ (CGFloat)scaleWithWidth:(CGFloat)width andWidthScale:(CGFloat)widthScale heihgtScale:(CGFloat)heihgtScale{
    CGFloat height = 0;
    height = (heihgtScale * width) / widthScale;
    return height;
}
@end
