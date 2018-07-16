//
//  NSObject+ValueForKeyPath.m
//  DemoCollectOC
//
//  Created by dulingkang on 2018/4/25.
//  Copyright © 2018年 Shawn.Du. All rights reserved.
//

#import "NSObject+ValueForKeyPath.h"
#import <objc/runtime.h>

@implementation NSObject (ValueForKeyPath)

+ (void)load {
    Method origin = class_getInstanceMethod([NSObject class], @selector(valueForKeyPath:));
    Method custom = class_getInstanceMethod([NSObject class], @selector(ss_valueForKeyPath:));
    method_exchangeImplementations(origin, custom);
}
  
- (id)ss_valueForKeyPath:(NSString *)keyPath {
  if (![keyPath isEqualToString:@"foregroundView"]) {
    return [self ss_valueForKeyPath:keyPath];
  } else {
    return nil;
  }
}
  
  
@end
