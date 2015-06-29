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

@interface Pin:PFObject<PFSubclassing>
@property UIColor *color;
@property NSDate *date;
@property NSNumber *latitude;
@property NSNumber *longitude;
@property NSNumber *userID;
@property NSString *text;

+ (NSString *)parseClassName;
@end
