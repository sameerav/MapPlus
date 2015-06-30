//
//  MapViewController.h
//  MapPlus
//
//  Created by Fletcher Woodruff on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@import GoogleMaps;

@interface MapViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSString *timeFilter;
@property (strong, nonatomic) NSString *emotionFilter;

@end
