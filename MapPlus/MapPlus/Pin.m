//
//  Pin.m
//  MapPlus
//
//  Created by Sameera Vemulapalli on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import "Pin.h"
#import <Parse/PFObject+Subclass.h>
#import <Parse/Parse.h>

@interface Pin ()
// these properties are so parse can handle storing the pin
@property float latitude;
@property float longtitude;
@property int red;
@property int blue;
@property int green;
@end

@implementation Pin

// necessary because Pin subclasses Parse's PFObject
@dynamic date;
@dynamic userID;
@dynamic text;
@dynamic latitude;
@dynamic longtitude;
@dynamic red;
@dynamic green;
@dynamic blue;

@synthesize color;
@synthesize position;

// this method is required for Pin to subclass Parse's PFObject
+ (NSString *)parseClassName {
    return @"Pin";
}

- (instancetype)initWithUser:(NSNumber *)userID
                        date:(NSDate *)date
                    location:(CLLocationCoordinate2D)position {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        [Pin registerSubclass];
    });
    
    self = [super init];
    if (self) {
        self.userID = userID;
        self.date = date;
        self.position = position;
        
        // change the position into JSON Serializable objects for Parse
        self.latitude = self.position.latitude;
        self.longtitude = self.position.longitude;
    }
    return self;
}

+ (void)registerSubclass {
    [super registerSubclass];
}

@end
