//
//  LoanInfoDeviceNews.h
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanInfoDeviceNews : NSObject

+(instancetype)shared;

//获取定位信息
- (void)getLocalInfo:(void(^)(NSString *lon,NSString *lat))complete;

//获取appId
- (NSString *)getAppId;

//获取当前版本
- (NSString *)getCurrentVersion;

//获取设备型号
- (NSString *)getCurrentDeviceModel;
@end
