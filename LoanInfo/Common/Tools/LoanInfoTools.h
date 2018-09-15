//
//  LoanInfoTools.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/12.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanInfoTools : NSObject

//获取当前控制器
+  (UIViewController *)getCurrentVC;
//控制侧滑
+ (void)interactivePopGestureRecognizerEnable:(BOOL)isEnable controllerView:(UIViewController *)vc;
//根据宽高比计算高度
+ (CGFloat)scaleWithWidth:(CGFloat)width andWidthScale:(CGFloat)widthScale heihgtScale:(CGFloat)heihgtScale;
@end
