//
//  LoanInfoLocation.m
//  LoanInfo
//
//  Created by Penghuaiyu on 2018/9/19.
//  Copyright © 2018年 Penghuaiyu. All rights reserved.
//

#import "LoanInfoLocation.h"
#import <CoreLocation/CoreLocation.h>

//获取经纬度信息
typedef void (^getLocalInfoBlock)(NSDictionary *info);

@interface LoanInfoLocation()
<
    CLLocationManagerDelegate
>

@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//城市
@property (nonatomic,copy)    NSString *strLatitude;//经度
@property (nonatomic,copy)    NSString *strLongitude;//维度

@property (nonatomic, copy) getLocalInfoBlock getLocalInfoBlock;

@end
@implementation LoanInfoLocation


+(instancetype)shared{
    static LoanInfoLocation *local = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        local = [[LoanInfoLocation alloc] init];
    });
    return local;
}

- (void)startLocal:(void(^)(NSDictionary *info))complete{
    if (complete) {
        if(self.strLatitude && self.strLongitude){
            complete(@{@"longitude":self.strLongitude,@"latitude":self.strLatitude});
            return;
        }
        self.getLocalInfoBlock = ^(NSDictionary *info) {
            complete(info);
        };
    }
    [self locatemap];
}

- (void)locatemap{
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc]init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [JXTAlertView showAlertViewWithTitle:@"定位" message:@"请在设置中打开定位" cancelButtonTitle:@"取消" buttonIndexBlock:^(NSInteger buttonIndex) {
        if(1 == buttonIndex){
            NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication]openURL:settingURL];
        }
    } otherButtonTitles:@"打开定位", nil];
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //当前的经纬度
    HYLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    self.strLongitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    self.strLatitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    self.getLocalInfoBlock(@{@"longitude":self.strLongitude,@"latitude":self.strLatitude});
    
    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        return;
    }
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            _currentCity = placeMark.locality;
            if (!_currentCity) {
                _currentCity = @"无法定位当前城市";
            }
            //看需求定义一个全局变量来接收赋值
            HYLog(@"当前国家 - %@",placeMark.country);//当前国家
            HYLog(@"当前城市 - %@",_currentCity);//当前城市
            HYLog(@"当前位置 - %@",placeMark.subLocality);//当前位置
            HYLog(@"当前街道 - %@",placeMark.thoroughfare);//当前街道
            HYLog(@"具体地址 - %@",placeMark.name);//具体地址
            NSString *message = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",placeMark.country,_currentCity,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
            HYLog(@"%@",message);
            
        }else if (error == nil && placemarks.count){
            
            HYLog(@"NO location and error return");
        }else if (error){
            
            HYLog(@"loction error:%@",error);
        }
    }];
}

@end
