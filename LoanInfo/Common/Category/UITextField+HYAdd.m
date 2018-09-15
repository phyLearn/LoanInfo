//
//  UITextField+HYAdd.m
//  AppFramework
//
//  Created by Penghuaiyu on 16/10/14.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import "UITextField+HYAdd.h"

@implementation UITextField (HYAdd)

#pragma mark - 键盘弹起自适应
/**
 *  适配屏幕
 */
-(void)autoAdaptationKeyBoard{
    
    //开始编辑
    [self addTarget:self action:@selector(editingBegin) forControlEvents:UIControlEventEditingDidBegin];
    //结束编辑
    [self addTarget:self action:@selector(editingEnd) forControlEvents:UIControlEventEditingDidEnd];
}

-(void)editingBegin{
    
    //适配键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)editingEnd{
    //移除观察
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyBoardWillHide:(NSNotification *)not{
    self.window.frame = [UIScreen mainScreen].bounds;
}

-(void)keyBoardWillShow:(NSNotification *)not{
    //获得键盘的frame
    CGRect keyboadRect = [not.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    //是否被键盘遮挡
    NSInteger distance = CGRectGetMaxY(self.frame) - keyboadRect.origin.y + kNavigationBarHeight;
    if (distance > 0) {
        self.window.frame = CGRectMake(0, -distance, self.window.frame.size.width, self.window.frame.size.height);
    }
}

@end
