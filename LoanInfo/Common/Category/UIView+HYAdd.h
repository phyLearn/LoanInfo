//
//  UIView+HYAdd.h
//  AppFramework
//
//  Created by Penghuaiyu on 16/10/17.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HYAdd)

/** X */
@property (nonatomic, assign) CGFloat x;

/** Y */
@property (nonatomic, assign) CGFloat y;

/** Width */
@property (nonatomic, assign) CGFloat width;

/** Height */
@property (nonatomic, assign) CGFloat height;

/** size */
@property (nonatomic, assign) CGSize size;

/** centerX */
@property (nonatomic, assign) CGFloat centerX;

/** centerY */
@property (nonatomic, assign) CGFloat centerY;

/** tag */
@property (nonatomic, copy) NSString *tagStr;

@end
