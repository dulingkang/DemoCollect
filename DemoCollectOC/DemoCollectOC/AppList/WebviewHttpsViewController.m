//
//  WebviewHttpsViewController.m
//  DemoCollectOC
//
//  Created by dulingkang on 16/8/31.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "WebviewHttpsViewController.h"

@interface WebviewHttpsViewController()<UIWebViewDelegate, NSURLConnectionDelegate, NSURLSessionDelegate>
@property (nonatomic, strong) UIWebView *webview;

@end
@implementation WebviewHttpsViewController {
    NSURLSession *_urlSession;
    BOOL _authenticated;
    NSMutableURLRequest *_request;
    NSString *url;
    
}

- (void)viewDidLoad {
    _webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webview.delegate = self;
    NSLog(@">>>>>%@", NSCocoaErrorDomain);
    [self.view addSubview:_webview];
    url = @"https://devthinking.com/nativeTest.html";
    url = @"https://testt.dmall.com/2rK9Kx?tradeConfId=c38bfd2a4ea64fcd8ae85fe2a2dfb17&amapId=B001C8RAU2&wareTotalNum=4&checkGiftStock=0&storeId=10456&venderId=48&from=IOS&hideCustomNavigationBar=1&canDeliver=1";
//    _request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [_webview loadRequest:_request];
//    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
//    
//    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"test.html"];
    
//    NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:8];
    [_webview loadRequest:_request];
//    [_webview loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
////    [contentData appendData:data];
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog(@"Bad: %@", [error description]);
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
////    NSString *loadedContent = [[NSString alloc] initWithData:
////                               contentData encoding:NSUTF8StringEncoding];
////    NSLog(@"Loaded content: %@",loadedContent);
//    
//}
//
//// ------------ ByPass ssl starts ----------
//-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:
//(NSURLProtectionSpace *)protectionSpace {
//    return [protectionSpace.authenticationMethod
//            isEqualToString:NSURLAuthenticationMethodServerTrust];
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:
//(NSURLAuthenticationChallenge *)challenge {
//    NSLog(@"WebController Got auth challange via NSURLConnection");
//    
//    if ([challenge previousFailureCount] ==0)
//        
//    {
//        
//        _authenticated =YES;
//        
//        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//        
//        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
//        
//    } else
//        
//    {
//        
//        [[challenge sender]cancelAuthenticationChallenge:challenge];
//        
//    }
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//
//{
//    
//    NSLog(@"WebController received response via NSURLConnection");
//    
//    // remake a webview call now that authentication has passed ok.
//    
//    _authenticated =YES;
//    
//    [_webview loadRequest:_request];
//    
//    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
//    
////    [_urlConnection cancel];
//    
//}
//
#pragma mark - webview delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"Did start loading: %@ auth:%d", [[request URL]absoluteString],_authenticated);
    
//    if (!_authenticated) {
//        
//        _authenticated =NO;
//        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:Nil];
//        NSURLSessionDataTask *task = [session dataTaskWithRequest:_request];
//        [task resume];
//        return NO;
    
//    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finish");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error {
    NSLog(@"***********error:%@,errorcode=%ld,errormessage:%@",error.domain,error.code,error.description);
    
    if (!([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code ==102)) {
        
        //当请求出错了会做什么事情
    }
}
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
// completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
//{
//    if ([[[challenge protectionSpace] authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//        SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
//        if (serverTrust != NULL) {
//            OSStatus status = SecTrustEvaluate(serverTrust, NULL);
//            if(!(errSecSuccess == status)) {
//                completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//                return;
//            }
//            
////            NSData *localCertData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
////                                                                    pathForResource:@"srca"
////                                                                    ofType:@"cer"]];
//            
//            SecCertificateRef remoteServerCert = SecTrustGetCertificateAtIndex(serverTrust, 0);
//            CFDataRef remoteCertData = SecCertificateCopyData(remoteServerCert);
////            BOOL isMatch = [localCertData isEqualToData: (__bridge NSData *)remoteCertData];
//            CFRelease(remoteCertData);
//            __block NSURLCredential *credential = nil;
//            credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//            if (credential) {
//                completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//            } else {
//                completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
//            }
//
////            [[challenge sender] useCredential:[NSURLCredential credentialForTrust:serverTrust] forAuthenticationChallenge:challenge];
////            if (isMatch) {
////                completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
////            } else {
////                completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
////            }
//        }
//    } else {
//        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
//    }
//}
//
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
//{
////    [_webview loadRequest:_request];
//}

@end
