//
//  AppDelegate.m
//  SDKDemo
//
//  Created by Sean Ooi on 7/22/15.
//  Copyright (c) 2015 Yella Inc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

NSString * const notificationRefreshKey = @"NotificationRefreshKey";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [RSDK sharedInstanceWithApiKey:@"MyAPIKey"];
    [RSDK sharedInstance].delegate = self;
    [RSDK sharedInstance].subsequentRangingInterval = 5;
    [[RSDK sharedInstance] setAuthorizationType:AuthorizationTypeAlways];
    [[RSDK sharedInstance] startMonitoring];
    
    _items = [NSMutableArray array];
    
    return YES;
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

#pragma mark - RaySDK Delegate Methods

- (void)rsdkDidRangeRayBeacon:(NSArray * __null_unspecified)beacon inRegionWithIdentifier:(NSString * __nonnull)identifier {
    NSLog(@"Did range %@", beacon);
}

- (void)rsdkDidEnterRegionWithIdentifier:(NSString * __nonnull)identifier {
    NSLog(@"Did enter region %@", identifier);
}

- (void)rsdkDidExitRegionWithIdentifier:(NSString * __nonnull)identifier {
    NSLog(@"Did exit region %@", identifier);
}

- (void)rsdkDidWalkInToBeacon:(RSDKBeacon * __null_unspecified)beacon inRegionWithIdentifier:(NSString * __nonnull)identifier {
    NSLog(@"Did walk in: %@", beacon);
    
    NSDictionary *item = @{
                           @"beacon": beacon,
                           @"key": identifier
                           };
    
    [_items addObject:item];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationRefreshKey object:nil];
}

- (void)rsdkDidWalkOutOfBeacon:(RSDKBeacon * __null_unspecified)beacon inRegionWithIdentifier:(NSString * __nonnull)identifier {
    NSLog(@"Did walk out: %@", beacon);
    
    for(NSDictionary *dict in _items) {
        if([dict[@"key"] isEqualToString:identifier]) {
            [_items removeObject:dict];
            break;
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationRefreshKey object:nil];
}

- (void)rsdkDidFailWithError:(NSError * __null_unspecified)error {
    NSLog(@"Error: %@", error);
}

- (void)rsdkBluetoothManagerDidUpdateState:(enum BluetoothState)state {
    switch (state) {
        case BluetoothStateUnknown:
            NSLog(@"Bluetooth state unknown");
            break;
            
        case BluetoothStateResetting:
            NSLog(@"Bluetooth state resetting");
            break;
            
        case BluetoothStateUnsupported:
            NSLog(@"Bluetooth state unsupported");
            break;
            
        case BluetoothStateUnauthorized:
            NSLog(@"Bluetooth state unauthorized");
            break;
            
        case BluetoothStatePoweredOff:
            NSLog(@"Bluetooth state powered off");
            break;
            
        case BluetoothStatePoweredOn:
            NSLog(@"Bluetooth state powered on");
            break;
            
        default:
            NSLog(@"Bluetooth state not in ENUM");
            break;
    }
}

@end
