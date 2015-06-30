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

@property (strong, nonatomic) UIColor *color;
@property (nonatomic) BOOL tag;
@property (strong, nonatomic) Pin *pin;

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location;
- (IBAction)addPin:(id)sender;

@property (nonatomic, copy) void (^saveBlock)(Pin *);
@property (weak, nonatomic) IBOutlet UITextView *text;

@end
