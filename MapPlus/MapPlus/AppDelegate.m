//
//  AppDelegate.m
//  MapPlus
//
//  Created by Fletcher Woodruff on 6/29/15.
//  Copyright (c) 2015 MapPlusTeam. All rights reserved.
//

#import <Parse/Parse.h>
#import "ParseAPI.h"
#import "AppDelegate.h"
#import "MapViewController.h"
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Set up Parse
    //    [self doParseSetup: launchOptions];
    // Initialize GoogleMaps with API key
    
    UIUserNotificationType types = UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    [GMSServices provideAPIKey:@"AIzaSyDDKPChzynlDv-f8NTFmxks_NLWJDvl34o"];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MapViewController* mvc = [[MapViewController alloc] init];
    
    UINavigationController *navController =
    [[UINavigationController alloc] initWithRootViewController:mvc];
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)doParseSetup: (NSDictionary *)launchOptions
{
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"ZtBPYEA3UbRJdB9jSTmnHLRiyoboJDmYd8Q48p53"
                  clientKey:@"akhxAGt9iu1kdHIqXk6lt30znH2ZL0z1IuPOKQFa"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
