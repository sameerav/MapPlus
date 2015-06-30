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

@property (copy, nonatomic) void (^saveBlock)(Pin *);

- (instancetype)initWithLocation:(CLLocationCoordinate2D)location;


@end
