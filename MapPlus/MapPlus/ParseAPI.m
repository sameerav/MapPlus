//
//  ParseAPI.m
//  MapPlus
//
//  Created by Sameera Vemulapalli on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#include <stdlib.h>
#import <Parse/Parse.h>
#import "ParseAPI.h"
#import "Pin.h"

@interface ParseAPI ()

@property (strong, nonatomic) NSMutableSet *debugSet;

@end

@implementation ParseAPI

static BOOL debugMode = YES;

+ (NSSet *) getPin24HoursOld{
    NSDate *now = [NSDate date];
    double timeInterval = 24*60*60*-1;
    NSDate *startDate = [now dateByAddingTimeInterval:timeInterval];
    return [self getPinsFromDate:startDate toDate:now];
    
}

+ (NSSet *) getPinWeekOld
{
    NSDate *now = [NSDate date];
    double timeInterval = 7*24*60*60*-1;
    NSDate *startDate = [now dateByAddingTimeInterval:timeInterval];
    return [self getPinsFromDate:startDate toDate:now];
}
+ (NSSet *) getPinMonthOld
{
    NSDate *now = [NSDate date];
    double timeInterval = 30*24*60*60*-1;
    NSDate *startDate = [now dateByAddingTimeInterval:timeInterval];
    return [self getPinsFromDate:startDate toDate:now];
}

+ (NSSet *) getPinsYearOld
{
    NSDate *now = [NSDate date];
    double timeInterval = 365*24*60*60*-1;
    NSDate *startDate = [now dateByAddingTimeInterval:timeInterval];
    return [self getPinsFromDate:startDate toDate:now];
}

+ (NSSet *) getPinsAllTime
{
    if (!debugMode) {
        //implement this
        NSArray *pinArray = [NSArray array];
        [Pin fetchAll:pinArray];
        NSSet *pinSet = [NSSet setWithArray:pinArray];
        return pinSet;
    } else {
        return [self oneHundredPins];
    }
}

+ (NSSet *) getPinsFromDate: (NSDate *)startDate toDate:(NSDate *)endDate
{
    if (!debugMode) {
        NSSet *allPinSet = [self getPinsAllTime];
        NSSet *pins = [allPinSet objectsPassingTest:^(id obj, BOOL *stop) {
            NSDate *pinDate = ((Pin *)obj).date;
            if (([pinDate earlierDate:endDate] == pinDate) && ([pinDate laterDate:startDate] == pinDate)) {
                return YES;
            } else {
                return NO;
            }
        }];
        return pins;
    } else {
        return [self oneHundredPins];
    }
}

+ (NSSet *)oneHundredPins
{
    NSMutableSet *out = [NSMutableSet set];
    
    NSDictionary *attributes = @{@1 : @[@"Angry",      [UIColor redColor]],
                                       @2 : @[@"Energetic",  [UIColor orangeColor]],
                                       @3 : @[@"Happy",      [UIColor yellowColor]],
                                       @4 : @[@"Jealous",    [UIColor greenColor]],
                                       @5 : @[@"Sad",        [UIColor blueColor]],
                                       @6 : @[@"Optimistic", [UIColor purpleColor]]};
    
    
    for (int ii = 0; ii < 100; ii++) {
        CLLocationDegrees latit = (float) arc4random_uniform(132) + arc4random_uniform(1000) / 1000;
        CLLocationDegrees longi = (float) arc4random_uniform(132) + arc4random_uniform(1000) / 1000;
        Pin *pin = [[Pin alloc] initWithUser:@0
                                        date:[NSDate date]
                                    location:CLLocationCoordinate2DMake(latit, longi)];
        
        NSArray *atts = attributes[[NSNumber numberWithUnsignedInt:(arc4random_uniform(6) + 1)]];
        pin.emotionString = atts[0];
        pin.color = atts[1];
        
        [out addObject:pin];
    }
    
    return out;
}

// methods to store pins
+ (BOOL) savePin:(Pin *)pin
{
    return [pin saveInBackground];
}

@end
