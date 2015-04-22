//
//  ViewController.m
//  LunchBaby
//
//  Created by randy on 15/4/22.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import "ViewController.h"
#import "ShopDataManager.h"
@interface ViewController ()
{
    ShopDataManager *dataManager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataManager = [[ShopDataManager alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.delegate = self;
    NSLog(@"%d",[CLLocationManager authorizationStatus]);
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%d",status);
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways)
    {
        [SVProgressHUD showWithStatus:@"定位中"];
        [locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [SVProgressHUD dismiss];
    [locationManager stopUpdatingLocation];
    CLLocation *userLocation = [locations lastObject];
    CLLocationCoordinate2D coordinate = userLocation.coordinate;
    NSLog(@"%f,%f,%ld",coordinate.latitude,coordinate.longitude,(long)userLocation.floor.level);
    NSLog(@"%@",userLocation.description);
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray *placemarks,NSError *err)
    {
        for (CLPlacemark *placemark in placemarks)
        {
            NSString *cityName = [placemark.locality substringWithRange:NSMakeRange(0, 2)];
            NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@",placemark.name,placemark.subAdministrativeArea,placemark.subLocality,placemark.subThoroughfare,placemark.thoroughfare,placemark.locality,placemark.administrativeArea,placemark.country);
            NSDictionary *queryParameters = @{@"category":@"美食",@"city":cityName,@"latitude":@(coordinate.latitude),@"longitude":@(coordinate.longitude),@"sort":@"1",@"limit":@"20",@"offset_type":@"1",@"out_offset_type":@"1",@"platform":@"2"};
            [dataManager searchForRestaurant:queryParameters];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
