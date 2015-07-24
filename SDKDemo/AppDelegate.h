//
//  AppDelegate.h
//  SDKDemo
//
//  Created by Sean Ooi on 7/22/15.
//  Copyright (c) 2015 Yella Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import RaySDK;

@interface AppDelegate : UIResponder <UIApplicationDelegate, RaySDKDelegate>

extern NSString *const notificationRefreshKey;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableArray* items;

@end

