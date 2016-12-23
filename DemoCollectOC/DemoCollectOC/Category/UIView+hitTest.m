//
//  UIView+hitTest.m
//  DemoCollectOC
//
//  Created by ShawnDu on 2016/12/23.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "UIView+hitTest.h"
#import <objc/runtime.h>

@implementation UIView (hitTest)

+ (void)load {
    Method origin = class_getInstanceMethod([UIView class], @selector(hitTest:withEvent:));
    Method custom = class_getInstanceMethod([UIView class], @selector(ss_hitTest:withEvent:));
    method_exchangeImplementations(origin, custom);
    
    origin = class_getInstanceMethod([self class], @selector(pointInside:withEvent:));
    custom = class_getInstanceMethod([self class], @selector(ss_pointInside:withEvent:));
    method_exchangeImplementations(origin, custom);
}

- (BOOL)ss_pointInside: (CGPoint)point withEvent: (UIEvent *)event {
    BOOL canAnswer = [self ss_pointInside:point withEvent:event];
    NSLog(@"%@ can answer %d", self.class, canAnswer);
    return canAnswer;
}

- (UIView *)ss_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *answerView = [self ss_hitTest:point withEvent:event];
    NSLog(@"hit view : %@", self.class);
    return answerView;
}

@end
