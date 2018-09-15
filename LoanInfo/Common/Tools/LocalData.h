//
//  LocalData.h
//  AppFramework
//
//  Created by Penghuaiyu on 16/10/12.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalData : NSObject

/**
 *  取本地的json数据
 */
+ (nullable id)getLocalJsonDataWithName:(NSString *)jsonName;

@end
