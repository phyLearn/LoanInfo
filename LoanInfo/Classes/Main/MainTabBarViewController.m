//
//  MainTabBarViewController.m
//  AppFramework
//
//  Created by Penghuaiyu on 16/10/13.
//  Copyright © 2016年 Penghuaiyu. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MainNavigationController.h"

@interface MainTabBarViewController ()
//基础设置字典
@property (nonatomic, strong) NSDictionary *infoDict;
@end

@implementation MainTabBarViewController


- (NSDictionary *)infoDict
{
    if(!_infoDict)
    {
        NSDictionary *dict = [LocalData getLocalJsonDataWithName:@"ChangeData.json"];
        _infoDict = dict[@"changeData"][@"tabbar"];
    }
    return _infoDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:self.infoDict[@"appearance"][@"selectColor"]]} forState:UIControlStateSelected];
    //加载json中的数据
    for(NSDictionary *dict in self.infoDict[@"baseSet"])
    {
        [self addChildViewController:dict[@"vcName"] title:dict[@"title"] imageName:dict[@"imageName"] selectImageName:dict[@"selectImageName"]];
    }
}

//加载子控制器
- (void)addChildViewController:(NSString *)vcName title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName
{
    Class cla = NSClassFromString(vcName);
    if(cla)
    {
        UIViewController *VC = [[cla alloc] init];
        VC.title = title;
        VC.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:[[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        MainNavigationController *nav = [[MainNavigationController alloc]initWithRootViewController:VC];
        
        [self addChildViewController:nav];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
