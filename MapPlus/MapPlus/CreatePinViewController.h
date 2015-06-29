//
//  CreatePinViewController.h
//  MapPlus
//
//  Created by Kathleen Feng on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface CreatePinViewController : UIViewController

@property (weak, nonatomic) UIColor *color;
@property (nonatomic) BOOL tag;

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location;
- (IBAction)addRedPin:(id)sender;
- (IBAction)addOrangePin:(id)sender;
- (IBAction)addYellowPin:(id)sender;
- (IBAction)addGreenPin:(id)sender;
- (IBAction)addBluePin:(id)sender;
- (IBAction)addPurplePin:(id)sender;
- (IBAction)cancel:(id)sender;

@end
