//
//  UIButton+HYAdd.h
//  AppFramework
//
//  Created by Penghuaiyu on 16/10/14.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^ActionBlock)();

@interface UIButton (HYAdd)

@property (nonatomic, copy) NSString *Type;
@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

@end
