//
//  SyncViewController.m
//  DemoCollectOC
//
//  Created by Shawn on 2017/8/7.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import "SyncViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <libkern/OSAtomic.h>
#import <pthread.h>

static long long const kLoopCount = 1000000;

@interface SyncViewController ()

@end

@implementation SyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSTimeInterval past = 0;
    NSTimeInterval now = 0;
    NSInteger i = 0;
    id obj = [NSObject new];
    
    dispatch_queue_t queue = dispatch_queue_create("com.shawn.Sync", DISPATCH_QUEUE_CONCURRENT);
    past = CFAbsoluteTimeGetCurrent();
    for(i = 0;i < kLoopCount; i++) {
        dispatch_barrier_async(queue, ^{});
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"dispatch_barrier_async: %f", now - past);
    
    past = CFAbsoluteTimeGetCurrent();
    for (i = 0; i < kLoopCount; i++) {
        __block BOOL complete = NO;
        dispatch_async(queue, ^{
            complete = YES;
        });
        while (!complete) {
        }
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"whileLoop: %f", now - past);
    
    past = CFAbsoluteTimeGetCurrent();
    for (i = 0; i < kLoopCount; i++) {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_async(queue, ^{
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"dispatch_semaphore: %f", now - past);
    
    past = CFAbsoluteTimeGetCurrent();
    for (i = 0; i < kLoopCount; i++) {
        @synchronized (obj) {
        }
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"@synchronized: %f", now - past);
    
    NSLock *lock = [NSLock new];
    past = CFAbsoluteTimeGetCurrent();
    for (i = 0; i < kLoopCount; i++) {
        [lock lock];
        [lock unlock];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"NSLock: %f", now - past);
    
    typedef void (*func)(id, SEL);
    SEL lockSEL = @selector(lock);
    SEL unlockSEL = @selector(unlock);
    func lockFunc = (void (*)(id, SEL))[lock methodForSelector : lockSEL];
    func unlockFunc = (void (*)(id, SEL))[lock methodForSelector : unlockSEL];
    past = CFAbsoluteTimeGetCurrent();
    for (i = 0; i < kLoopCount; i++) {
        lockFunc(lock, lockSEL);
        unlockFunc(lock, lockSEL);
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"NSLock+IMP: %f", now - past);
    
    NSConditionLock *conditionLock = [NSConditionLock new];
    past = CFAbsoluteTimeGetCurrent();
    for (i = 0; i < kLoopCount; i++) {
        [conditionLock lock];
        [conditionLock unlock];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"NSConditionLock: %f", now - past);
    
    NSRecursiveLock *recursiveLock = [NSRecursiveLock new];
    past = CFAbsoluteTimeGetCurrent();
    for (i = 0; i < kLoopCount; i++) {
        [recursiveLock lock];
        [recursiveLock unlock];
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"NSRecursiveLock: %f", now - past);
    
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    past = CFAbsoluteTimeGetCurrent();
    for(i = 0;i < kLoopCount; i++) {
        pthread_mutex_lock(&mutex);
        pthread_mutex_unlock(&mutex);
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"pthread_mutex: %f", now - past);
    
    OSSpinLock spinlock = OS_SPINLOCK_INIT;
    past = CFAbsoluteTimeGetCurrent();
    for(i = 0;i < kLoopCount; i++) {
        OSSpinLockLock(&spinlock);
        OSSpinLockUnlock(&spinlock);
    }
    now = CFAbsoluteTimeGetCurrent();
    NSLog(@"OSSpinLock: %f", now - past);
}


@end
