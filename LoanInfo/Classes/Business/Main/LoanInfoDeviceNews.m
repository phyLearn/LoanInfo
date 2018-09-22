//
//  LoanInfoDeviceNews.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoDeviceNews.h"
#import "LoanInfoLocation.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation LoanInfoDeviceNews

+(instancetype)shared{
    static LoanInfoDeviceNews *deviceNews = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceNews = [[LoanInfoDeviceNews alloc] init];
    });
    return deviceNews;
}

- (void)getLocalInfo:(void(^)(NSString *lon,NSString *lat))complete{
    
    [[LoanInfoLocation shared] startLocal:^(NSDictionary *info) {
        if(complete)
            complete(info[@"longitude"],info[@"latitude"]);
    }];
}

- (NSString *)getAppId{
    return @":appid";
}

//获取app版本号
- (NSString *)getCurrentVersion{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    return currentAppVersion;
}

//获得设备型号
- (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";// (A1203)
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";// (A1241/A1324)
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";// (A1303/A1325)
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";// (A1332)
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";// (A1332)
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";// (A1349)
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";// (A1387/A1431)
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";// (A1428)
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";// (A1429/A1442)
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";// (A1456/A1532)
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";// (A1507/A1516/A1526/A1529)
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";// (A1453/A1533)
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";// (A1457/A1518/A1528/A1530)
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";// (A1522/A1524)
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";// (A1549/A1586)
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6S";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6SPlus";
    
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch1G";// (A1213)
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";// (A1288)
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";// (A1318)
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";// (A1367)
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";// (A1421/A1509)
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad1G";// (A1219/A1337)
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";// (A1395)
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";// (A1396)
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";// (A1397)
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";// (A1395+New Chip)
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadMini1G";// (A1432)
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadMini1G";// (A1454)
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadMini1G";// (A1455)
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";// (A1416)
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";// (A1403)
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";// (A1430)
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";// (A1458)
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";//(A1459)
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";// (A1460)
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";// (A1474)
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";// (A1475)
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";// (A1476)
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadMini2G";// (A1489)
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadMini2G";// (A1490)
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadMini2G";// (A1491)
    
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

@end
