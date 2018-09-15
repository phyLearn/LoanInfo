//
//  LoanInfolittleImageBtn.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/13.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfolittleImageBtn.h"

@implementation LoanInfolittleImageBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect imageRect = CGRectZero;
    imageRect.size = CGSizeMake(contentRect.size.width *.5, contentRect.size.height * .5);
    imageRect.origin.x = contentRect.size.width / 4;
    imageRect.origin.y = contentRect.size.height / 4;
    return imageRect;
}

@end
