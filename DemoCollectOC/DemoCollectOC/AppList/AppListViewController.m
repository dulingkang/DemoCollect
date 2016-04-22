//
//  AppListViewController.m
//  DemoCollectOC
//
//  Created by Shawn.Du on 16/3/31.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "AppListViewController.h"
#import <objc/runtime.h>

static NSString* const installedAppListPath = @"/private/var/mobile/Library/Caches/com.apple.mobile.installation.plist";

@interface AppListViewController ()

@end

@implementation AppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self scan];
    NSLog(@"installedApp:%@", [self installedApp]);
}

-(NSMutableArray *)desktopAppsFromDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *desktopApps = [NSMutableArray array];
    
    for (NSString *appKey in dictionary)
    {
        [desktopApps addObject:appKey];
    }
    return desktopApps;
}

-(NSArray *)installedApp
{
    BOOL isDir = NO;
    if([[NSFileManager defaultManager] fileExistsAtPath: installedAppListPath isDirectory: &isDir] && !isDir)
    {
        NSMutableDictionary *cacheDict = [NSDictionary dictionaryWithContentsOfFile: installedAppListPath];
        NSDictionary *system = [cacheDict objectForKey: @"System"];
        NSMutableArray *installedApp = [NSMutableArray arrayWithArray:[self desktopAppsFromDictionary:system]];
        
        NSDictionary *user = [cacheDict objectForKey: @"User"];
        [installedApp addObjectsFromArray:[self desktopAppsFromDictionary:user]];
        
        return installedApp;
    }
    
    NSLog(@"can not find installed app plist");
    return nil;
}



- (void)scan
{
    
        Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
        NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
        NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
}

- (void)scanApps
{
    NSString *directory = NSHomeDirectory();
    NSLog(@"directory:%@", directory);
    
    NSString *pathOfApplications;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        pathOfApplications = @"/var/mobile/Containers/";
    else
        pathOfApplications = @"/var/mobile/Applications";
    
    NSLog(@"scan begin");
    
    // all applications
    NSArray *arrayOfApplications = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathOfApplications error:nil];
    
    for (NSString *applicationDir in arrayOfApplications) {
        // path of an application
        NSString *pathOfApplication = [pathOfApplications stringByAppendingPathComponent:applicationDir];
        NSArray *arrayOfSubApplication = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathOfApplication error:nil];
        // seek for *.app
        for (NSString *applicationSubDir in arrayOfSubApplication) {
            if ([applicationSubDir hasSuffix:@".app"]) {// *.app
                NSString *path = [pathOfApplication stringByAppendingPathComponent:applicationSubDir];
                NSString *imagePath = [pathOfApplication stringByAppendingPathComponent:applicationSubDir];
                path = [path stringByAppendingPathComponent:@"Info.plist"];
                // so you get the Info.plist in the dict
                NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
                if([[dict allKeys] containsObject:@"CFBundleIdentifier"] && [[dict allKeys] containsObject:@"CFBundleDisplayName"]){
                    NSArray *values = [dict allValues];
                    NSString *icon;
                    for (int i = 0; i < values.count; i++) {
                        icon = [self getIcon:[values objectAtIndex:i] withPath:imagePath];
                        if (![icon isEqualToString:@""]) {
                            imagePath = [imagePath stringByAppendingPathComponent:icon];
                            break;
                        }
                    }
                }
            }
        }
    }
}

- (NSString *)getIcon:(id)value withPath:(NSString *)imagePath
{
    if([value isKindOfClass:[NSString class]]) {
        NSRange range = [value rangeOfString:@"png"];
        NSRange iconRange = [value rangeOfString:@"icon"];
        NSRange IconRange = [value rangeOfString:@"Icon"];
        if (range.length > 0){
            NSString *path = [imagePath stringByAppendingPathComponent:value];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            if (image != nil && image.size.width > 50 && image.size.height > 50) {
                return value;
            }
        }
        else if(iconRange.length > 0){
            NSString *imgUrl = [NSString stringWithFormat:@"%@.png",value];
            NSString *path = [imagePath stringByAppendingPathComponent:imgUrl];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            if (image != nil && image.size.width > 50 && image.size.height > 50) {
                return imgUrl;
            }
        }
        else if(IconRange.length > 0){
            NSString *imgUrl = [NSString stringWithFormat:@"%@.png",value];
            NSString *path = [imagePath stringByAppendingPathComponent:imgUrl];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            if (image != nil && image.size.width > 50 && image.size.height > 50) {
                return imgUrl;
            }
        }
    }
    else if([value isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)value;
        for (id subValue in [dict allValues]) {
            NSString *str = [self getIcon:subValue withPath:imagePath];
            if (![str isEqualToString:@""]) {
                return str;
            }
        }
    }
    else if([value isKindOfClass:[NSArray class]]){
        for (id subValue in value) {
            NSString *str = [self getIcon:subValue withPath:imagePath];
            if (![str isEqualToString:@""]) {
                return str;
            }
        }
    }
    return @"";
}

@end
