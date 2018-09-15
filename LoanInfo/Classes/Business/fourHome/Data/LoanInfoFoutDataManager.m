//
//  LoanInfoFoutDataManager.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/7.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoFoutDataManager.h"

@implementation LoanInfoFoutDataManager

+(instancetype)shared{
    static LoanInfoFoutDataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[LoanInfoFoutDataManager alloc] init];
    });
    return dataManager;
}

- (void)getFourCellDataComplete:(void(^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    [NSMutableDictionary dictionary];
    NSMutableArray *sectionArr = [NSMutableArray array];
    //第一组数据
    NSMutableDictionary *oneCellDict = [NSMutableDictionary dictionary];
    NSArray *oneSectionArr = @[@{@"title":@"帮助中心",@"section":@"goToHelpCenter",@"imageName":@"loaninfohelpcenter"},
                               @{@"title":@"在线客服",@"section":@"goToServeOnline",@"imageName":@"loaninfoserveonline"}
                               ];
    [oneCellDict setObject:oneSectionArr forKey:@"cellArr"];
    [sectionArr addObject:oneCellDict];
    
    NSMutableDictionary *secondDict = [NSMutableDictionary dictionary];
    NSArray *secondSectionArr = @[@{@"title":@"关于我们",@"section":@"goToAboutOur",@"imageName":@"loaninfoaboutour"},
                                  @{@"title":@"设置",@"section":@"goToSetting",@"imageName":@"loaninfosetting"}];
    [secondDict setObject:secondSectionArr forKey:@"cellArr"];
    [sectionArr addObject:secondDict];
    [resultDict setObject:sectionArr forKey:@"sectionArr"];
    if(complete)
        complete([resultDict copy]);
}

- (void)getFourHeaderDataComplete:(void(^)(NSDictionary *dict))complete{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    [resultDict setObject:@"loaninfomyicon" forKey:@"iconImage"];
    [resultDict setObject:@"18711093252" forKey:@"mobileText"];
    if(complete)
        complete(resultDict);
}

@end
