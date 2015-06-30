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
    //    NSArray *pinArray = [NSArray array];
    //[Pin fetchAll:pinArray];
    PFQuery *query = [PFQuery queryWithClassName:@"Pin"];
    NSArray *pinArray = [query findObjects];
    NSSet *pinSet = [NSSet setWithArray:pinArray];
    for (Pin *pin in pinSet) {
        [pin setUpFromParse];
    }
//    NSLog(@"Retrived %f items", [pinSet count]);
    return pinSet;
}

+ (NSSet *) getPinsFromDate: (NSDate *)startDate toDate:(NSDate *)endDate
{
    NSSet *allPinSet = [self getPinsAllTime];
    NSSet *pins = [allPinSet objectsPassingTest:^(id obj, BOOL *stop) {
        Pin *pin = (Pin *)obj;
        NSDate *pinDate = pin.date;
        if (([pinDate earlierDate:endDate] == pinDate) && ([pinDate laterDate:startDate] == pinDate)) {
            return YES;
        } else {
            return NO;
        }
    }];
//    NSLog(@"Retried %f items", [pins count]);
    return pins;
}

// methods to store pins
+ (BOOL) savePin:(Pin *)pin
{
//    PFObject *PFPin = [PFObject objectWithClassName:@"Pin"];
//    PFPin[@"date"] = pin.date;
//    PFPin[@"text"] = @"";
//    PFPin[@"latitude"] = @(pin.position.latitude);
//    PFPin[@"longitude"] = @(pin.position.longitude);
//    CGFloat red;
//    CGFloat blue;
//    CGFloat green;
//    CGFloat alpha;
//    [pin.color getRed:&red green:&green blue:&blue alpha:&alpha];
//    PFPin[@"red"] = @(red);
//    PFPin[@"blue"] = @(blue);
//    PFPin[@"green"] = @(green);
//    PFPin[@"alpha"] = @(alpha);
//    PFPin[@"X-Parse-Installation-Id"] = @"";
    
    PFObject *PFPin = [PFObject objectWithClassName:@"MapViewController"];
    
//    ((Pin *)PFPin).color = pin.color;
//    ((Pin *)PFPin).pinMarker = pin.pinMarker;
//    ((Pin *)PFPin).colorString = @"";
//    ((Pin *)PFPin).userID = @5;
//    ((Pin *)PFPin).position = pin.position;
    
//    [PFPin setObject:@"" forKey:@"color"];
//    [PFPin setObject:@"" forKey:@"pinMarker"];
//    [PFPin setObject:@"" forKey:@"colorString"];
//    [PFPin setObject:@"" forKey:@"userID"];
//    [PFPin setObject:@"" forKey:@"position"];

    
    [PFPin saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         NSLog(@"YAYAYYAYYA");
         NSLog(@"error: %@", error);
     }];

    return YES;
    
}

@end
