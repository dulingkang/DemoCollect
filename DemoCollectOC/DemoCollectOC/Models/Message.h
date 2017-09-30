//
//  Message.h
//  DemoCollectOC
//
//  Created by Shawn on 2017/9/26.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

@interface Message : NSObject<WCTTableCoding>
@property (nonatomic) NSInteger localID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSDate *createTime;
@property (nonatomic, copy) NSDate *modifiedTime;

WCDB_PROPERTY(localID)
WCDB_PROPERTY(content)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(modifiedTime)
@end
