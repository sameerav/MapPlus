//
//  MapViewController.m
//  MapPlus
//
//  Created by Fletcher Woodruff on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import "MapViewController.h"
#import "FilterViewController.h"
@import GoogleMaps;
#import "CreatePinViewController.h"

@interface MapViewController ()

@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) NSMutableDictionary *pins;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end

@implementation MapViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.pins = [NSMutableDictionary dictionary];
        
        self.navigationItem.title = @"MapPlus";
        
        UIBarButtonItem *filterPinButton =
        [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(filterPinButtonPressed:)];
        
        self.navigationItem.leftBarButtonItem = filterPinButton;
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
}

// Mark - Button Press Methods

- (void)filterPinButtonPressed:(id)sender
{
    NSLog(@"Filter Pin Button Pressed");
    
    FilterViewController *fvc = [[FilterViewController alloc] init];
    
    UINavigationController *nc =
    [[UINavigationController alloc] initWithRootViewController:fvc];
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:nc animated:YES completion:nil];
    
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
    
    [self presentViewController:nc animated:YES completion:nil];
    
    GMSMarker *marker = [[GMSMarker alloc] init];

    marker.position = coordinate;
    marker.title = @"Gratuitously titled things";
    marker.snippet = @"Hello World";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.mapView;
}

@end
