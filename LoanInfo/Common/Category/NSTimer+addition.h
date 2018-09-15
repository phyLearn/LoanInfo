//
//  NSTimer+addition.h
//  WYHomeLoopView
//
//  Created by 王启镰 on 16/5/5.
//  Copyright © 2016年 wanglijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (addition)

/**
 *  暂停定时器
 */
- (void)pause;
/**
 *  开始定时器
 */
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

@end
