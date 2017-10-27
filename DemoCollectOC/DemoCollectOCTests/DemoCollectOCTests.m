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


- (void)testProcessLinkJumpToCMBMobileBankURL {
    NSURL *url1 = [NSURL URLWithString:@"http://cmbls/FunctionJump?id=1&action=gofunid&cmb_app_trans_parms_start=here&Tr=false"];
    NSURL *url2 = [NSURL URLWithString:@"http://cmbls/FunctionJump?clean=true&action=gofunid&cmb_app_trans_parms_start=here&Tr=false"];
    NSURL *url3 = [NSURL URLWithString:@"http://cmbls/FunctionJump?action=gofunid&clean=true&cmb_app_trans_parms_start=here&Tr=false"];
    NSURL *url4 = [NSURL URLWithString:@"http://cmbls/FunctionJump?action=gofunid&Tr=false"];
    NSLog(@"%@\n,%@\n,%@\n,%@\n", [self processLinkJumpToCMBMobileBankURL:url1], [self processLinkJumpToCMBMobileBankURL:url2], [self processLinkJumpToCMBMobileBankURL:url3], [self processLinkJumpToCMBMobileBankURL:url4]);
    
}

- (NSURL *)processLinkJumpToCMBMobileBankURL:(NSURL *)url {
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSArray *queryItems = [components queryItems];
    NSMutableArray *queryMutableItems = [NSMutableArray arrayWithArray:queryItems];
    BOOL findClean = NO;
    BOOL findCmbAppTrans = NO;
    for (NSURLQueryItem *item in queryItems) {
        if ([item.name isEqualToString:@"clean"]) {
            findClean = YES;
        } else if ([item.name isEqualToString:@"cmb_app_trans_parms_start"]) {
            findCmbAppTrans = YES;
        }
    }
    if (!findClean) {
        NSURLQueryItem *cleanQueryItem = [NSURLQueryItem queryItemWithName:@"clean" value:@"false"];
        [queryMutableItems insertObject:cleanQueryItem atIndex:0];
    }
    if (!findCmbAppTrans) {
        NSURLQueryItem *cleanQueryItem = [NSURLQueryItem queryItemWithName:@"cmb_app_trans_parms_start" value:@"here"];
        [queryMutableItems addObject:cleanQueryItem];
    }
    NSURLQueryItem *openIdQueryItem = [NSURLQueryItem queryItemWithName:@"openid" value:@"123456"];
    [queryMutableItems addObject:openIdQueryItem];
    components.queryItems = queryMutableItems;
    return components.URL;
}
@end
