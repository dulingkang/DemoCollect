//
//  DCGlobalDef.h
//  DemoCollectOC
//
//  Created by Shawn.Du on 16/4/22.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#ifndef DCGlobalDef_h
#define DCGlobalDef_h

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


#endif /* DCGlobalDef_h */
