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
@property CGFloat red;
@property CGFloat blue;
@property CGFloat green;
@property CGFloat alpha;
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
@dynamic alpha;

@synthesize color;
@synthesize position;
@synthesize pinMarker;
@synthesize colorString;

// this method is required for Pin to subclass Parse's PFObject
+ (NSString *)parseClassName {
    return @"Pin";
}

- (instancetype)initWithUser:(NSNumber *)userID
                        date:(NSDate *)date
                    location:(CLLocationCoordinate2D)location
                       color:(UIColor *)colour {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        [Pin registerSubclass];
    });
    
    self = [super init];
    if (self) {
        self.userID = userID;
        self.date = date;
        self.position = location;
        
        // change the position into JSON Serializable objects for Parse
        self.latitude = self.position.latitude;
        self.longtitude = self.position.longitude;
        
        NSDictionary *colorDict = @{[UIColor redColor]: @"red", [UIColor orangeColor]: @"orange", [UIColor yellowColor]:@"yellow", [UIColor greenColor]:@"green", [UIColor blueColor]:@"blue", [UIColor purpleColor]:@"purple"};
        self.colorString = colorDict[self.color];
        
        // Getting RGB components from UIColor
        CGColorRef colorRef = [colour CGColor];
        const CGFloat *components = CGColorGetComponents(colorRef);
        self.red = components[0];
        self.green = components[1];
        self.blue = components[2];
        self.alpha = components[3];
        self.color = colour;
    }
    return self;
}

- (UIColor *)color {
    return [[UIColor alloc] initWithRed:self.red green:self.green blue:self.blue alpha:self.alpha];
}

+ (void)registerSubclass {
    [super registerSubclass];
}

@end
