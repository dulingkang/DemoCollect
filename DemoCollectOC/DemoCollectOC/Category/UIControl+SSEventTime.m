//
//  UIControl+SSEventTime.m
//  DemoCollectOC
//
//  Created by ShawnDu on 2016/12/11.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "UIControl+SSEventTime.h"
#import <objc/runtime.h>

@interface UIControl()
@property (nonatomic, assign) NSTimeInterval eventTime;
@end

@implementation UIControl (SSEventTime)

+ (void)load {
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    Method systemMethod = class_getInstanceMethod(self, sysSEL);
    Method customMethod = class_getInstanceMethod(self, customSEL);
    
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    } else {
        method_exchangeImplementations(systemMethod, customMethod);
    }
    
}

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.eventTime >= self.eventInterval);
    if (self.eventInterval > 0) {
        self.eventTime = NSDate.date.timeIntervalSince1970;
    }
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
    }
}

#pragma mark - getter setter
- (NSTimeInterval)eventInterval {
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval")doubleValue];
}

- (void)setEventInterval:(NSTimeInterval)eventInterval {
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(eventInterval), OBJC_ASSOCIATION_RETAIN);
}

- (NSTimeInterval)eventTime {
    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime")doubleValue];
}

- (void)setEventTime:(NSTimeInterval)eventTime {
    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(eventTime), OBJC_ASSOCIATION_RETAIN);
}
@end


