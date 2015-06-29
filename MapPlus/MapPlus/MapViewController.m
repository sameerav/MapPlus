//
//  MapViewController.m
//  MapPlus
//
//  Created by Fletcher Woodruff on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import "MapViewController.h"
@import GoogleMaps;

@interface MapViewController ()

@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) NSMutableDictionary *pins;

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
        
        // Initialize mapView
        double fbLatitude = 37.4844666;
        double fbLongitude = -122.1479385;
        int fbZoomLevel = 16;
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:fbLatitude
                                                                longitude:fbLongitude
                                                                     zoom:fbZoomLevel];
        
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
    
    CLLocationDegrees latit = 0;
    CLLocationDegrees longit = 0;
    
    [self.mapView animateToLocation:CLLocationCoordinate2DMake(latit, longit)];
}

// Mark - GMSMapViewDelegate Methods

- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    // Should present AddPinScreen modally
    
    GMSMarker *marker = [[GMSMarker alloc] init];

    marker.position = coordinate;
    marker.title = @"Gratuitously titled things";
    marker.snippet = @"Hello World";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.mapView;
}

@end
