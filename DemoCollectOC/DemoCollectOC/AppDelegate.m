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
#import <mach/mach.h>

#define kCachePath(cacheFolder) [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES).firstObject stringByAppendingString:[NSString stringWithFormat:@"/%@", cacheFolder]]

static int64_t _YYDeviceMemoryTotal() {
    int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
    if (mem < -1) mem = -1;
    return mem;
}

static int64_t _YYDeviceMemoryFree() {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.free_count * page_size;
}

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

    NSLog(@"total:%lf", _YYDeviceMemoryTotal()/1024.0/1024.0);
    NSLog(@"free:%lf", _YYDeviceMemoryFree()/1024.0/1024.0);
    
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return YES;
}

@end
