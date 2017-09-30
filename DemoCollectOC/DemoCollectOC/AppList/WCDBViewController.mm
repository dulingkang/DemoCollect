//
//  WCDBViewController.m
//  DemoCollectOC
//
//  Created by Shawn on 2017/9/26.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import "WCDBViewController.h"
#import "DCGlobalDef.h"
#import "Message.h"

@interface WCDBViewController ()
@property (nonatomic, strong) WCTDatabase *database;
@property (nonatomic, strong) WCTTable *table;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation WCDBViewController

static NSString *const kMessageTable = @"Message";
static NSString *const kPassword = @"123456";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"path: %@", kDocumentPath);
    [self addInsertButton];
    [self table];
    [self addTextView];
    [self cipherDB];
}

#pragma mark - event respons
- (void)insertButtonPressed {
    Message *message = [[Message alloc] init];
    message.localID = random();
    message.content = @"Hello, WCDB!";
    message.createTime = [NSDate date];
    message.modifiedTime = [NSDate date];
    /*
     INSERT INTO message(localID, content, createTime, modifiedTime)
     VALUES(1, "Hello, WCDB!", 1496396165, 1496396165);
     */
    [self.database insertObject:message into:kMessageTable];
}

#pragma mark - getter
- (WCTDatabase *)database {
    if (!_database) {
        NSString *path = [kDocumentPath stringByAppendingPathComponent:@"wcdb/wcdb.db"];
        _database = [[WCTDatabase alloc] initWithPath: path];
        NSData *password = [kPassword dataUsingEncoding:NSASCIIStringEncoding];
//        [_database setCipherKey:password];
    }
    return _database;
}

- (WCTTable *)table {
    if (!_table) {
        _table = [self.database getTableOfName:kMessageTable withClass:Message.class];
        if (!_table) {
            [self.database createTableAndIndexesOfName:kMessageTable withClass:Message.class];
        }
    }
    return _table;
}

#pragma mark - private method
- (void)addInsertButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 66, 200, 50);
    [button setTitle:@"add" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(insertButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)addTextView {
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, ScreenHeight - 200)];
    NSArray<Message *> *messages = [self.database getObjectsOfClass:Message.class fromTable:kMessageTable orderBy:Message.localID.order()];
    NSMutableString *string = [NSMutableString string];
    for (Message *message in messages) {
        [string appendString:[NSString stringWithFormat:@"localID = %ld, content = %@, createTime = %@, modifiedTime = %@ \n", message.localID, message.content, message.createTime, message.modifiedTime]];
    }
    _textView.text = string;
    [self.view addSubview:_textView];
}

- (void)cipherDB {
    NSString *path = [kDocumentPath stringByAppendingPathComponent:@"wcdb/encrypted.db"];
    [self.database exec:WCDB::StatementAttach().attach(WCDB::Expr::Expr(path.UTF8String), "DATABASE").as("encrypted KEY '123456'")];
    WCTResultList columnResultList = {"sqlcipher_export('encrypted');"};
    WCDB::StatementSelect select = WCDB::StatementSelect();
    select.select(columnResultList, false);
    [self.database exec:select];
    [self.database exec:WCDB::StatementDetach().detach("DATABASE encrypted;")];
}

@end
