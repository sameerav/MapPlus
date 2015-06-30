//
//  CreatePinViewController.h
//  MapPlus
//
//  Created by Kathleen Feng on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
@class Pin;

@interface CreatePinViewController : UIViewController

@property (weak, nonatomic) UIColor *color;
@property (nonatomic) BOOL tag;
@property (strong, nonatomic) Pin *pin;

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location;
- (IBAction)addRedPin:(id)sender;
- (IBAction)addOrangePin:(id)sender;
- (IBAction)addYellowPin:(id)sender;
- (IBAction)addGreenPin:(id)sender;
- (IBAction)addBluePin:(id)sender;
- (IBAction)addPurplePin:(id)sender;

@property (nonatomic, copy) void (^saveBlock)(Pin *);

@end
