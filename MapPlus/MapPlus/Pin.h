//
//  Pin.h
//  MapPlus
//
//  Created by Sameera Vemulapalli on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface Pin : NSObject
@property UIColor *color;
@property NSDate *date;
@property CLLocationCoordinate2D position;
@property NSNumber *userID;
@property NSString *text;

- (instancetype)initWithUser:(NSNumber *)userID
                        date:(NSDate *)date
                    location:(CLLocationCoordinate2D)position;

@end
