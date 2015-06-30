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
@end

@implementation Pin

// necessary because Pin subclasses Parse's PFObject
@dynamic date;
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
@synthesize userID;

// this method is required for Pin to subclass Parse's PFObject
+ (NSString *)parseClassName {
    return @"Pin";
}

- (instancetype)initWithUser:(NSNumber *)userID
                        date:(NSDate *)date
                    location:(CLLocationCoordinate2D)coordinates {

    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        [Pin registerSubclass];
    });
    
    self = [super init];
    if (self) {
        self.userID = userID;
        self.date = date;
        self.position = coordinates;
        
        // change the position into JSON Serializable objects for Parse
        self.latitude = coordinates.latitude;
        self.longtitude = coordinates.longitude;
        self.text = @"";
        self.latitude = 1.0;
        self.longtitude = 1.0;
        CGFloat red;
        CGFloat blue;
        CGFloat green;
        CGFloat alpha;
        [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
        self.red = red;
        self.blue = blue;
        self.green = green;
        
    }
    return self;
}

- (void)setUpFromParse
{
    self.color = [[UIColor alloc] initWithRed:self.red green:self.green blue:self.blue alpha:1.0];
    self.position = CLLocationCoordinate2DMake(self.latitude, self.longtitude);
}

- (void)setColor:(UIColor *)newColor
{
    color = newColor;
    
    // Getting RGB components from UIColor
    CGColorRef colorRef = [newColor CGColor];
    
    const CGFloat *components = CGColorGetComponents(colorRef);
    self.red = components[0];
    self.green = components[1];
    self.blue = components[2];
    self.alpha = components[3];
}

- (UIColor *)color {
    return [[UIColor alloc] initWithRed:self.red
                                  green:self.green
                                   blue:self.blue
                                  alpha:self.alpha];
}

+ (void)registerSubclass {
    [super registerSubclass];
}

@end
