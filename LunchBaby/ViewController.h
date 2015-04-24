//
//  ViewController.h
//  LunchBaby
//
//  Created by randy on 15/4/22.
//  Copyright (c) 2015年 randy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SVProgressHUD.h"
@interface ViewController : UIViewController<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CLLocationManager *locationManager;
}
@end

