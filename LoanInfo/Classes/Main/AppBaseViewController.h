//
//  AppBaseViewController.h
//  AppFramework
//
//  Created by Penghuaiyu on 16/10/14.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置左边按钮的点击事件
 */
typedef void (^leftBtnAction)(void);
/**
 *  设置右边按钮的点击事件
 */
typedef void (^rightBtnAction)(void);

@interface AppBaseViewController : UIViewController
/**
 *  让键盘自适应
 */
- (void)autoKeyBoard;

/**
 *  设置导航栏左右边按钮
 *
 *  @param name   按钮图片名
 *  @param action 动作block
 */
- (void)setLeftImageNamed:(NSString *)name action:(leftBtnAction)action;
- (void)setRightImageNamed:(NSString *)name action:(rightBtnAction)action;

@end
