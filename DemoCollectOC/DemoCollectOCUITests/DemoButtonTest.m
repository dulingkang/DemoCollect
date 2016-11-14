//
//  DemoButtonTest.m
//  DemoCollectOC
//
//  Created by ShawnDu on 2016/11/14.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "DemoBaseUITest.h"

@interface DemoButtonTest : DemoBaseUITest

@end

@implementation DemoButtonTest

- (void)testDemoButton {
    [self.app.buttons[@""] tap];
}

@end
