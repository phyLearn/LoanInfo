//
//  LocalData.m
//  AppFramework
//
//  Created by Penghuaiyu on 16/10/12.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import "LocalData.h"

@implementation LocalData

+ (nullable id)getLocalJsonDataWithName:(NSString *)jsonName
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:jsonName ofType:nil]];
    id info = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    return info;
}

@end
