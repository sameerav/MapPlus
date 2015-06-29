//
//  ParseAPI.h
//  MapPlus
//
//  Created by Sameera Vemulapalli on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@class Pin;

@interface ParseAPI : NSObject
// methods to get pins
- (NSSet *) getPin24HoursOld;
- (NSSet *) getPinWeekOld;
- (NSSet *) getPinMonthOld;
- (NSSet *) getPinsYearOld;
- (NSSet *) getPinsAllTime;
- (NSSet *) getPinsFromDate: (NSDate *)startDate toDate:(NSDate *)endDate;

// methods to store pins
- (BOOL) savePin:(Pin *)pin;

@end
