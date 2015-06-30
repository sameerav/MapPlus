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
@property (strong, nonatomic) NSMutableSet *allPins;
@property (strong, nonatomic) NSMutableDictionary *pinMarkerMap;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _allPins = [NSMutableSet set];
        _pinMarkerMap = [NSMutableDictionary dictionary];
        _dateFilter = @"";
        _emotionFilter = [NSMutableSet setWithArray:@[@"Angry",
                                                      @"Energetic",
                                                      @"Happy",
                                                      @"Jealous",
                                                      @"Sad",
                                                      @"Optimistic"]];
        
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
    //[self refreshPinsSet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

// Mark - Button Press Methods

- (void)filterPinButtonPressed:(id)sender
{
    NSLog(@"Filter Pin Button Pressed");
    
    FilterViewController *fvc = [[FilterViewController alloc] initWithMVC:self];
    
    UINavigationController *nc =
    [[UINavigationController alloc] initWithRootViewController:fvc];
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:nc animated:YES completion:^{
        [self refreshPinsSet];
    }];
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
            //[ParseAPI savePin:pin];
            //Remove once parse saving is added
            [self.allPins addObject:pin];
            [self refreshPinsSet];
        }];
    };
    
    [self presentViewController:nc animated:YES completion:nil];
}


// Mark - Fetching pins from data store

- (void)refreshPinsSet
{
    // Fetch pins from Parse
    
    NSSet *newPins = nil;
    
    if (self.dateFilter) {
        if ([self.dateFilter isEqualToString:@"day"]) {
            newPins = [ParseAPI getPin24HoursOld];
        } else if ([self.dateFilter isEqualToString:@"month"]) {
            newPins = [ParseAPI getPinMonthOld];
        } else if ([self.dateFilter isEqualToString:@"year"]){
            newPins = [ParseAPI getPinsYearOld];
        }
    } else {
        newPins = [ParseAPI getPinsAllTime];
    }
    
    //This needs to be done in a callback
    
    [self.allPins unionSet:newPins];
    
    if (self.emotionFilter) {
        self.allPins = [[self.allPins objectsPassingTest:^(id obj, BOOL *stop) {
            Pin* pin = (Pin *) obj;
            if([self.emotionFilter containsObject:pin.emotionString]) {
                return YES;
            } else {
                GMSMarker *marker = [self.pinMarkerMap objectForKey:pin.pinID];
                marker.map = nil;
                return NO;
            };
        }] mutableCopy];
    }
    
    for (Pin *pin in self.allPins) {
        if (![self.pinMarkerMap objectForKey:pin.pinID]) {
            GMSMarker *marker = [self createPinMarker:pin];
            marker.map = self.mapView;
            [self.pinMarkerMap setObject:marker forKey:pin.pinID];
        }
    }
    
    NSLog(@"%@", self.allPins);
    
}

- (GMSMarker *)createPinMarker:(Pin *)pin;
{
    GMSMarker *marker = [GMSMarker markerWithPosition:pin.position];
    
    marker.icon = [GMSMarker markerImageWithColor:pin.color];
    marker.position = pin.position;
    marker.snippet = pin.text;
    marker.title = pin.emotionString;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    
    return marker;
}

@end
