//
//  UIViewController+Hidden.m
//  CardManage
//
//  Created by Penghuaiyu on 2018/7/3.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

//用于统一控制导航栏的显示隐藏
#import "UIViewController+Hidden.h"

@implementation UIViewController (Hidden)

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if(viewController == self){
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        //系统相册继承自UINavigationController 这个不能隐藏 直接return
        if([UINavigationController isKindOfClass:[UIImagePickerController class]]){
            return;
        }
        //不在本页时，显示真正的navbar
        [navigationController setNavigationBarHidden:NO animated:YES];
        //当不显示本页时，要么就push到下一页，要么就PopL了，那么久将delegate设置为nil
        //之前将这段代码放到viewDidDisappear了，这种情况已经被pop了，self.navigationController为nil,这里采用手动持有navigationController的引用来解决
        if(navigationController.delegate == (id)self){
            //如果delegate是自己才设置为nil,因为viewWillAppear调用此方法较早，其他controller如果设置了delegate就可能误伤
            navigationController.delegate = nil;
        }
    }
}
@end
