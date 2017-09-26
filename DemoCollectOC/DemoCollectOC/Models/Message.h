//
//  Message.h
//  DemoCollectOC
//
//  Created by Shawn on 2017/9/26.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (nonatomic) NSInteger localID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSDate *createTime;
@property (nonatomic, copy) NSDate *modifiedTime;
@end
