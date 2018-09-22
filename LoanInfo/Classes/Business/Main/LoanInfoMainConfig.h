//
//  LoanInfoMainConfig.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SPACEHEIGHT  10
#define LEFTPACEHEIGHT 10

@interface LoanInfoMainConfig : NSObject

//分割线颜色
+ (UIColor *)getLineColor;

//背景颜色
+ (UIColor *)getBackgroundColor;

//按钮颜色
+ (UIColor *)getBtnColor;

//获取浅蓝色
+ (UIColor *)getBlueColor;

//获取黄色
+ (UIColor *)getYellowColor;

//获取粉色
+ (UIColor *)getRedColor;

//获取浅色字体
+ (UIColor *)getLighGrayColor;

//获取遮罩颜色
+ (UIColor *)getCoverViewColor;

//统一设置app名称
+ (NSString *)getAppName;

@end
