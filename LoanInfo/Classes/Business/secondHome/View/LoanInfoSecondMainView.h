//
//  LoanInfoSecondMainView.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanInfoSecondMainView : UIView

//当前view的tag
@property (nonatomic, assign) NSInteger currentTag;

//刷新table
- (void)refresCellDataWithDict:(NSDictionary *)dict page:(NSString *)inpage;

@end
