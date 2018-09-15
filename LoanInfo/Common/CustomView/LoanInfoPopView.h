//
//  LoanInfoPopView.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/8.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanInfoPopView : NSObject

+(instancetype)shared;

//显示行为校验弹框
- (void)showActionCheckPopView;
@end
