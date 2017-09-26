//
//  Message.m
//  DemoCollectOC
//
//  Created by Shawn on 2017/9/26.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import "Message.h"
#import <WCDB/WCDB.h>

@interface Message()<WCTTableCoding>
WCDB_PROPERTY(localID)
WCDB_PROPERTY(content)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(modifiedTime)
@end

@implementation Message

WCDB_IMPLEMENTATION(Message)
WCDB_SYNTHESIZE(Message, localID)
WCDB_SYNTHESIZE(Message, content)
WCDB_SYNTHESIZE(Message, createTime)
WCDB_SYNTHESIZE(Message, modifiedTime)
WCDB_PRIMARY(Message, localID)
WCDB_INDEX(Message, "_index", createTime)

@end
