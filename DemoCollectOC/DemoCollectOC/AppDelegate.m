//
//  AppDelegate.m
//  DemoCollectOC
//
//  Created by Shawn.Du on 16/3/31.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "AppDelegate.h"
#import "JPEngine.h"
#import "DMCustomURLSessionProtocol.h"

#define kCachePath(cacheFolder) [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES).firstObject stringByAppendingString:[NSString stringWithFormat:@"/%@", cacheFolder]]

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSURLProtocol registerClass:[DMCustomURLSessionProtocol class]];
    [JPEngine startEngine];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];

    [JPEngine evaluateScript:script];
    
#ifdef __IPHONE_9_0
    NSLog(@"this is iphone more than ios9");
#else
    NSLog(@"this is iphone less than ios9");
#endif
    NSLog(@">>>>>>:%@", kCachePath(@"test"));
    NSLog(@"%f", NSFoundationVersionNumber);
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_8_4) {
        NSLog(@"this is iphone more than ios9");
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    UIView *eTestView = [[UIView alloc] init];
    char *str1 = @encode(int);
    char *str2 = @encode(NSInteger);
    char *str3 = @encode(id);
    char *str4 = @encode(CGRect);
    char *str5 = @encode(CGPoint);
#pragma clang diagnostic pop

    
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

@end
