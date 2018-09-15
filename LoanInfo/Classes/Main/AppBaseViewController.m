//
//  AppBaseViewController.m
//  AppFramework
//
//  Created by Penghuaiyu on 16/10/14.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import "AppBaseViewController.h"
#import "UITextField+HYAdd.h"
#import "UIButton+HYAdd.h"

@interface AppBaseViewController ()

@end

@implementation AppBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self touchHideKeyboard];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)autoKeyBoard
{
    [self obtainAllTextField:self.view];
}

#pragma mark - 键盘相关
/**
 *  获取所有的textField
 */
- (void)obtainAllTextField:(UIView *)view
{
    if([view isKindOfClass:[UITextField class]]){
        [(UITextField *)view autoAdaptationKeyBoard];
    }
    
    NSArray * subviews = view.subviews;
    if(subviews && [subviews count]>0){
        for(UIView * sv in subviews){
            [self obtainAllTextField:sv];
        }
    }
}

/**
 *  点击收起键盘
 */
- (void)touchHideKeyboard
{
    //initWithActionBlock这个事YYKit封装的方法
    UITapGestureRecognizer *onetap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self.view endEditing:YES];
    }];
    [self.view addGestureRecognizer:onetap];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

//设置导航栏左边按钮
- (void)setLeftImageNamed:(NSString *)name action:(leftBtnAction)action {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 24, 24);
    UIImage *image = [UIImage imageNamed:name];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn handleControlEvent:UIControlEventTouchUpInside withBlock:action];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

//设置导航栏右边按钮
- (void)setRightImageNamed:(NSString *)name action:(rightBtnAction)action {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image2=  [UIImage imageNamed:name];
    rightBtn.frame =CGRectMake(0, 0, 50, 44);
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 0, -10);
    [rightBtn setImage:image2 forState:UIControlStateNormal];
    [rightBtn handleControlEvent:UIControlEventTouchUpInside withBlock:action];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

@end
