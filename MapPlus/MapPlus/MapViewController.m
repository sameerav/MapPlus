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

@end

@implementation MapViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.navigationItem.title = @"MapPlus";
        
        UIBarButtonItem *filterPinButton =
        [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(filterPinButtonPressed:)];
        
        UIBarButtonItem *addPinButton =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                      target:self
                                                      action:@selector(addPinButtonPressed:)];
        
        self.navigationItem.leftBarButtonItem = filterPinButton;
        self.navigationItem.rightBarButtonItem = addPinButton;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    double fbLatitude = 37.4844666;
    double fbLongitude = -122.1479385;
    int fbZoomLevel = 16;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:fbLatitude
                                                            longitude:fbLongitude
                                                                 zoom:fbZoomLevel];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    // Available map types: kGMSTypeNormal, kGMSTypeSatellite, kGMSTypeHybrid,
    // kGMSTypeTerrain, kGMSTypeNone
    
    // Set the mapType to Satellite
    mapView.mapType = kGMSTypeNormal;
    self.view = mapView;
}

- (void)filterPinButtonPressed:(id)sender
{
    NSLog(@"Filter Pin Button Pressed");
}

- (void)addPinButtonPressed:(id)sender
{
    NSLog(@"Add Pin Button Pressed");
}


@end
