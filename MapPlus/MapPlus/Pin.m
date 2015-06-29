//
//  Pin.m
//  MapPlus
//
//  Created by Sameera Vemulapalli on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import "Pin.h"
#import <Parse/PFObject+Subclass.h>

@implementation Pin

// necessary because Pin subclasses Parse's PFObject
@dynamic color;
@dynamic date;
@dynamic position;
@dynamic userID;
@dynamic text;

// this method is required for Pin to subclass Parse's PFObject
+ (NSString *)parseClassName {
    return @"Pin";
}

- (instancetype)initWithUser:(NSNumber *)userID
                        date:(NSDate *)date
                    location:(CLLocationCoordinate2D)position {
    self = [super init];
    if (self) {
        self.userID = userID;
        self.date = date;
        self.position = position;
    }
    return self;
}

@end
