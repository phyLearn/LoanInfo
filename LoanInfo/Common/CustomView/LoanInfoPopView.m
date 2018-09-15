//
//  LoanInfoPopView.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/8.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoPopView.h"
#import "ZJAnimationPopView.h"
#import <GT3Captcha/GT3Captcha.h>

@interface LoanInfoPopView()
<
    GT3CaptchaManagerDelegate,
    GT3CaptchaButtonDelegate
>

@property (nonatomic, strong) ZJAnimationPopView *actionCheckPopView;//行为校验弹框
@property (nonatomic, strong) GT3CaptchaButton *captchaButton;//校验btn

@end

@implementation LoanInfoPopView

+(instancetype)shared{
    static LoanInfoPopView *popView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popView = [[LoanInfoPopView alloc] init];
    });
    return popView;
}

//- (void)showActionCheckPopView{
//    self.actionCheckPopView = [[ZJAnimationPopView alloc] initWithCustomView:[self createActionCheckPopView] popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
//    self.actionCheckPopView.popAnimationDuration = 0.5f;
//    self.actionCheckPopView.isClickBGDismiss = YES;
//    [self.actionCheckPopView pop];
//}
//
//- (UIView *)createActionCheckPopView{
//    //自定义样式
//    CGFloat backWidth = AppScreenWidth - 80;
//    CGFloat backHeight = backWidth * 0.2;
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backWidth, backHeight)];
//    backView.backgroundColor = [UIColor whiteColor];
//    backView.layer.cornerRadius = 5;
//
//    //创建验证管理器实例
//    GT3CaptchaManager *captchaManager = [[GT3CaptchaManager alloc] initWithAPI1:@"http://www.geetest.com/demo/gt/register-slide" API2:@"http://www.geetest.com/demo/gt/validate-slide" timeout:5.0];
//    captchaManager.maskColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
//    captchaManager.delegate = self;
//    //debug mode
//            [captchaManager enableDebugMode:YES];
//    //创建验证视图的实例
//    self.captchaButton = [[GT3CaptchaButton alloc] initWithFrame:backView.frame captchaManager:captchaManager];
//    //推荐直接开启验证
//    [self.captchaButton startCaptcha];
//    [backView addSubview:self.captchaButton];
//    return backView;
//}
//
//#pragma MARK - GT3CaptchaManagerDelegate
//- (void)gtCaptcha:(GT3CaptchaManager *)manager errorHandler:(GT3Error *)error {
//    //处理验证中返回的错误
//    if (error.code == -999) {
//        // 请求被意外中断, 一般由用户进行取消操作导致, 可忽略错误
//    }
//    else if (error.code == -10) {
//        // 预判断时被封禁, 不会再进行图形验证
//    }
//    else if (error.code == -20) {
//        // 尝试过多
//    }
//    else {
//        // 网络问题或解析失败, 更多错误码参考开发文档
//    }
//}
//
//- (void)gtCaptcha:(GT3CaptchaManager *)manager didReceiveSecondaryCaptchaData:(NSData *)data response:(NSURLResponse *)response error:(GT3Error *)error decisionHandler:(void (^)(GT3SecondaryCaptchaPolicy))decisionHandler {
//    if (!error) {
//        //处理你的验证结果
//        NSLog(@"\ndata: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        //成功请调用decisionHandler(GT3SecondaryCaptchaPolicyAllow)
//        decisionHandler(GT3SecondaryCaptchaPolicyAllow);
//        //失败请调用decisionHandler(GT3SecondaryCaptchaPolicyForbidden)
//        //decisionHandler(GT3SecondaryCaptchaPolicyForbidden);
//        [self.actionCheckPopView dismiss];
//    }
//    else {
//        //二次验证发生错误
//        decisionHandler(GT3SecondaryCaptchaPolicyForbidden);
//    }
//}

@end
