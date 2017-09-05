//
//  URLSessionViewController.m
//  DemoCollectOC
//
//  Created by Shawn on 2017/9/5.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import "URLSessionViewController.h"

@interface URLSessionViewController ()

@end

@implementation URLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self post];
}

- (void)post {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/postBodyData"];
    NSDictionary *dict = @{@"name": @"Shawn"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data = %@, response = %@", data, response);
    }];
    [task resume];
}
@end
