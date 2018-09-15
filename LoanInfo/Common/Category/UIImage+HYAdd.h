//
//  UIImage+HYAdd.h
//  AppFramework
//
//  Created by Penghuaiyu on 16/10/19.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HYAdd)

/**
 *  解决图片上传过程中图片在服务端旋转90度的问题
 *
 *  @param aImage 需要处理的图片
 *
 *  @return 处理好的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end
