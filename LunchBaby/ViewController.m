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
@property (strong, nonatomic) CLLocation *currentLocation;
@property (weak, nonatomic) IBOutlet UITableView *restaurantListView;
@property (strong, nonatomic) NSMutableArray *restaurants;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurants = [[NSMutableArray alloc] init];
    UIButton *locateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locateButton setShowsTouchWhenHighlighted:YES];
    locateButton.frame = CGRectMake(0, 0, 25, 25);
    [locateButton setBackgroundImage:[UIImage imageNamed:@"Location"] forState:UIControlStateNormal];
    [locateButton addTarget:self action:@selector(locateManually) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *locateBarButton = [[UIBarButtonItem alloc] initWithCustomView:locateButton];
    UIBarButtonItem *cityBarButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    cityBarButton.tintColor = [UIColor blackColor];
    [cityBarButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItems = @[locateBarButton,cityBarButton];
    dataManager = [[ShopDataManager alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.delegate = self;
    NSLog(@"%d",[CLLocationManager authorizationStatus]);
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
        {
            [locationManager requestWhenInUseAuthorization];
        }
    }
    else
    {
        [locationManager startUpdatingLocation];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)locateManually
{
    
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
    [SVProgressHUD showWithStatus:@"Retrieving Info"];
    [locationManager stopUpdatingLocation];
    CLLocation *userLocation = [locations lastObject];
    CLLocationCoordinate2D coordinate = userLocation.coordinate;
    NSLog(@"%f,%f",coordinate.latitude,coordinate.longitude);
    NSLog(@"%@",userLocation.description);
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray *placemarks,NSError *err)
    {
        for (CLPlacemark *placemark in placemarks)
        {
            NSString *cityName = [placemark.locality substringWithRange:NSMakeRange(0, 2)];
            NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@",placemark.name,placemark.subAdministrativeArea,placemark.subLocality,placemark.subThoroughfare,placemark.thoroughfare,placemark.locality,placemark.administrativeArea,placemark.country);
            UIBarButtonItem *city = self.navigationItem.leftBarButtonItems[1];
            city.title = cityName;
            NSDictionary *queryParameters = @{@"category":@"美食",@"city":cityName,@"latitude":@(coordinate.latitude),@"longitude":@(coordinate.longitude),@"sort":@"1",@"limit":@"20",@"offset_type":@"1",@"out_offset_type":@"1",@"platform":@"2"};
            [dataManager searchForRestaurant:queryParameters];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
