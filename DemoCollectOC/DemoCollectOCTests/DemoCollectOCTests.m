//
//  DemoCollectOCTests.m
//  DemoCollectOCTests
//
//  Created by ShawnDu on 16/4/28.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import <XCTest/XCTest.h>

#define DMAppstoreEvaluateShowTimeKey @"DMAppstoreEvaluateShowTimeKey"
#define DMAppstoreEvaluateMonthCountKey @"DMAppstoreEvaluateMonthCountKey"

@interface DemoCollectOCTests : XCTestCase

@end

@implementation DemoCollectOCTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRandom {
    int i = arc4random() % 4;
    XCTAssertTrue(i >= 0 && i < 4);
}

- (void)testCalendar {
    [self getdate];
    [self checkIfNeedShow];
}

-(void)getdate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm:ss"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
    
    NSDate *now = [NSDate new];
    NSString *dateString = [format stringFromDate:now];
    NSString *theDate = [dateFormat stringFromDate:now];
    NSString *theTime = [timeFormat stringFromDate:now];
    
    NSString *week = [dateFormatter stringFromDate:now];
    NSLog(@"\n"
          "theDate: |%@| \n"
          "theTime: |%@| \n"
          "Now: |%@| \n"
          "Week: |%@| \n"
          , theDate, theTime,dateString,week);
}

- (BOOL)checkIfNeedShow {
    NSDate *lastStoredDate = [[NSUserDefaults standardUserDefaults] objectForKey:DMAppstoreEvaluateShowTimeKey];
    NSDate *now = [NSDate new];
    if (!lastStoredDate) {
        [[NSUserDefaults standardUserDefaults] setObject:now forKey:DMAppstoreEvaluateShowTimeKey];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:DMAppstoreEvaluateMonthCountKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    
    BOOL needShow = NO;
    if ([now timeIntervalSinceDate:lastStoredDate] >= 7 * 24 * 3600) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MMM"];
        NSString *currentMonth = [format stringFromDate:now];
        NSString *lastMonth = [format stringFromDate:lastStoredDate];
        NSInteger monthCount = [[NSUserDefaults standardUserDefaults] integerForKey:DMAppstoreEvaluateMonthCountKey];
        if (![currentMonth isEqualToString:lastMonth]) {
            monthCount = 1;
        } else {
            monthCount++;
        }
        [[NSUserDefaults standardUserDefaults] setInteger:monthCount forKey:DMAppstoreEvaluateMonthCountKey];
        if (monthCount <= 2) {
            needShow = YES;
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate new] forKey:DMAppstoreEvaluateShowTimeKey];
        }
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
    return needShow;
}

@end
