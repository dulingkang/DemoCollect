//
//  DDLogViewController.m
//  DemoCollectOC
//
//  Created by dulingkang on 16/4/22.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "DDLogViewController.h"
#import "DCGlobalDef.h"


@implementation DDLogViewController

- (void)viewDidLoad {
    DDFileLogger* fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 6;
    fileLogger.maximumFileSize = 1024 * 512;
    DDLogInfo(@"log file at: %@", [[fileLogger currentLogFileInfo] filePath]);
    [DDLog addLogger:fileLogger];
}
@end
