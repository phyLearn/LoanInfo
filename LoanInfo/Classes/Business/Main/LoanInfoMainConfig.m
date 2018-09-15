//
//  LoanInfoMainConfig.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

//用来控制app整个UI形态
#import "LoanInfoMainConfig.h"

@implementation LoanInfoMainConfig

//总体分割线颜色
+ (UIColor *)getLineColor{
    UIColor *lineColor = [UIColor colorWithHexString:@"#F3F3F3"];
    return lineColor;
}

+ (UIColor *)getBackgroundColor{
    UIColor *backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
    return backgroundColor;
}

+ (UIColor *)getBtnColor{
    UIColor *btnColor = [UIColor colorWithHexString:@"#cccrrr"];
    return btnColor;
}

+ (UIColor *)getBlueColor{
    UIColor *blueColor = [UIColor colorWithHexString:@"#208DDF"];
    return blueColor;
}

+ (UIColor *)getRedColor{
    UIColor *redColor = [UIColor colorWithHexString:@"#FDF1E6"];
    return redColor;
}

+ (UIColor *)getLighGrayColor{
    UIColor *grayColor = [UIColor lightGrayColor];
    return grayColor;
}

+ (UIColor *)getYellowColor{
    UIColor *yellowColor = [UIColor colorWithHexString:@"#FF6600"];
    return yellowColor;
}

+ (NSString *)getAppName{
    return @"易贷江湖";
}
@end
