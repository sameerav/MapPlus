//
//  MapViewController.m
//  MapPlus
//
//  Created by Fletcher Woodruff on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import "MapViewController.h"
#import "FilterViewController.h"
#import "CreatePinViewController.h"
#import "ParseAPI.h"
#import "Pin.h"
@import GoogleMaps;

@interface MapViewController ()

@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) NSMutableSet *pins;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end

@implementation MapViewController


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.pins = [NSMutableSet set];
        
        self.navigationItem.title = @"MapPlus";
        
        UIBarButtonItem *filterPinButton =
        [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(filterPinButtonPressed:)];
        
        self.navigationItem.leftBarButtonItem = filterPinButton;
        
        UIBarButtonItem *refreshPinButton =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                      target:self
                                                      action:@selector(refreshPinButtonPressed:)];
        
        self.navigationItem.rightBarButtonItem = refreshPinButton;
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 20;
        self.locationManager.delegate = self;
        
        [self.locationManager requestWhenInUseAuthorization];
        
        [self.locationManager startUpdatingLocation];
        
        // Initialize mapView
        int zoomLevel = 16;
        
        CLLocationCoordinate2D coords = self.locationManager.location.coordinate;
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coords.latitude
                                                                longitude:coords.longitude
                                                                     zoom:zoomLevel];
        
        GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        mapView.delegate = self;
        
        
        // Set the mapType to a drawn representation
        mapView.mapType = kGMSTypeNormal;
        
        
        self.mapView = mapView;
        self.view = mapView;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshPinsSet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

// Mark - Button Press Methods

- (void)filterPinButtonPressed:(id)sender
{
    NSLog(@"Filter Pin Button Pressed");
    
    FilterViewController *fvc = [[FilterViewController alloc] init];
    fvc.mvc = self;
    
    UINavigationController *nc =
    [[UINavigationController alloc] initWithRootViewController:fvc];
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:nc animated:YES completion:nil];
    
}

- (void)refreshPinButtonPressed:(id)sender
{
    [self refreshPinsSet];
}

// Mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Did Update Location");

    CLLocationCoordinate2D coords = ((CLLocation *)[locations firstObject]).coordinate;
    
    [self.mapView animateToLocation:coords];
    
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Did fail with error");
}

// Mark - GMSMapViewDelegate Methods

- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    CreatePinViewController *cpvc = [[CreatePinViewController alloc] initWithLocation:coordinate];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:cpvc];
    
    cpvc.saveBlock = ^(Pin *pin) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (!pin.pinMarker) {
                pin.pinMarker = [self createPinMarker:pin];
            }
            
            // Store to Parse
            
            [self.pins addObject:pin];
        }];
    };
    
    [self presentViewController:nc animated:YES completion:nil];
}


// Mark - Fetching pins from data store

- (void)refreshPinsSet
{
    // Fetch pins from
    NSSet *newPins;
    if (self.timeFilter) {
        if ([self.timeFilter isEqualToString:@"day"]) {
            newPins = [ParseAPI getPin24HoursOld];
        } else if ([self.timeFilter isEqualToString:@"month"]) {
            newPins = [ParseAPI getPinMonthOld];
        } else if ([self.timeFilter isEqualToString:@"year"]){
            newPins = [ParseAPI getPinsYearOld];
        }
    } else {
        newPins = [ParseAPI getPinsAllTime];
    }
    if (self.emotionFilter) {
        [self.pins objectsPassingTest:^(id obj, BOOL *stop) {
            NSDictionary *colorDict = @{@"red": [UIColor redColor], @"orange": [UIColor orangeColor], @"yellow": [UIColor yellowColor], @"green": [UIColor greenColor], @"blue": [UIColor blueColor], @"purple": [UIColor purpleColor]};
            if ([colorDict[self.emotionFilter] isEqual:((Pin *)obj).color]) {
                return YES;
            } else {
                return NO;
            }
        }];
    }
    
    for (Pin* pin in newPins) {
        if ([self.pins containsObject:pin]) {
            continue;
        }
        
        if (!pin.pinMarker) {
            pin.pinMarker = [self createPinMarker:pin];
        }
        
    }
    
    [self.pins unionSet:newPins];
    
    // FILTER THE PINS HERE BASED ON THE FILTER SETTINGS
}

- (GMSMarker *)createPinMarker:(Pin *)pin
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    
    marker.icon = [GMSMarker markerImageWithColor:pin.color];
    marker.snippet = pin.text;
    marker.title = pin.colorString;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.mapView;
    
    return marker;
}

@end
