//
//  ParseAPI.m
//  MapPlus
//
//  Created by Sameera Vemulapalli on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import "ParseAPI.h"
#import "Pin.h"
#import <Parse/Parse.h>

@implementation ParseAPI

- (NSSet *) getPin24HoursOld{
    NSDate *now = [NSDate date];
    double timeInterval = 24*60*60*-1;
    NSDate *startDate = [now dateByAddingTimeInterval:timeInterval];
    return [self getPinsFromDate:startDate toDate:now];
    
}

- (NSSet *) getPinWeekOld
{
    NSDate *now = [NSDate date];
    double timeInterval = 7*24*60*60*-1;
    NSDate *startDate = [now dateByAddingTimeInterval:timeInterval];
    return [self getPinsFromDate:startDate toDate:now];
}
- (NSSet *) getPinMonthOld
{
    NSDate *now = [NSDate date];
    double timeInterval = 30*24*60*60*-1;
    NSDate *startDate = [now dateByAddingTimeInterval:timeInterval];
    return [self getPinsFromDate:startDate toDate:now];
}

- (NSSet *) getPinsYearOld
{
    NSDate *now = [NSDate date];
    double timeInterval = 365*24*60*60*-1;
    NSDate *startDate = [now dateByAddingTimeInterval:timeInterval];
    return [self getPinsFromDate:startDate toDate:now];
}

- (NSSet *) getPinsAllTime
{
    //implement this
    PF_NULLABLE NSArray *pinArray = [NSArray array];
    [Parse fetchAll:pinArray];
    NSSet *pinSet = [NSSet setWithArray:pinArray];
    return pinSet;
}

- (NSSet *) getPinsFromDate: (NSDate *)startDate toDate:(NSDate *)endDate
{
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
}

// methods to store pins
- (BOOL) savePin:(Pin *)pin
{
    [pin saveInBackground];
}

@end
