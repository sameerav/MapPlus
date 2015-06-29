//
//  Pin.h
//  MapPlus
//
//  Created by Sameera Vemulapalli on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@import GoogleMaps;

@interface Pin:PFObject<PFSubclassing>

- (instancetype)initWithUser:(NSNumber *)userID
                        date:(NSDate *)date
                    location:(CLLocationCoordinate2D)position;

@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) CLLocationCoordinate2D position;
@property (strong, nonatomic) NSNumber *userID;
@property (strong, nonatomic) NSString *text;

+ (NSString *)parseClassName;

+ (void)registerSubclass;

@end