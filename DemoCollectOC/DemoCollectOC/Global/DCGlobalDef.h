//
//  DCGlobalDef.h
//  DemoCollectOC
//
//  Created by Shawn.Du on 16/4/22.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#ifndef DCGlobalDef_h
#define DCGlobalDef_h

#import <CocoaLumberjack/CocoaLumberjack.h>

#if defined( LOG_ASYNC_ENABLED )
#undef LOG_ASYNC_ENABLED
#define LOG_ASYNC_ENABLED NO
#endif

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelAll;
#else
static const DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

//单例化一个类
#define SingletonDefine(className) \
\
+ (className *)sharedInstance;

#define SingletonImpl(className) \
\
+ (className *)sharedInstance { \
static className *instance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance;\
}

#define WEAK_SELF  typeof(self) __weak weakSelf=self;

//UI
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#endif /* DCGlobalDef_h */
