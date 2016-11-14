//
//  DemoBaseUITest.m
//  DemoCollectOC
//
//  Created by ShawnDu on 2016/11/14.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "DemoBaseUITest.h"

@implementation DemoBaseUITest

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    self.app = [XCUIApplication new];
    [self.app launch];
}

@end
