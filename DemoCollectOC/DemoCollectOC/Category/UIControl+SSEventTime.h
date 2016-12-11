//
//  UIControl+SSEventTime.h
//  DemoCollectOC
//
//  Created by ShawnDu on 2016/12/11.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (SSEventTime)
@property (nonatomic) NSTimeInterval eventInterval; //重复点击加间隔
@end
