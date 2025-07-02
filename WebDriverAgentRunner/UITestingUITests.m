/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <XCTest/XCTest.h>

#import <WebDriverAgentLib/FBDebugLogDelegateDecorator.h>
#import <WebDriverAgentLib/FBConfiguration.h>
#import <WebDriverAgentLib/FBFailureProofTestCase.h>
#import <WebDriverAgentLib/FBWebServer.h>
#import "XCUIScreen.h"

@interface UITestingUITests : FBFailureProofTestCase <FBWebServerDelegate>
@end

@implementation UITestingUITests

+ (void)setUp {
    [FBDebugLogDelegateDecorator decorateXCTestLogger];
    [FBConfiguration disableRemoteQueryEvaluation];
    [FBConfiguration configureDefaultKeyboardPreferences];
    [FBConfiguration disableApplicationUIInterruptionsHandling];
    if (NSProcessInfo.processInfo.environment[@"ENABLE_AUTOMATIC_SCREENSHOTS"]) {
        [FBConfiguration enableScreenshots];
    } else {
        [FBConfiguration disableScreenshots];
    }
    [super setUp];
}

//
//- (void)testnetwork {
//    NSString *urlString = @"http://www.baidu.com";
//    NSLog(@"#### 6.5.0 Welcome to EasyClick ipa process, website: http://ieasyclick.com #####");
//
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//
//    NSURL *url = [NSURL URLWithString:urlString];
//
//    NSURLRequest * _Nullable request = [NSURLRequest requestWithURL:url];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"testnetwork %@",str);
//        }
//    ];
//    [dataTask resume];
//}

/**
 Never ending test used to start WebDriverAgent
 */
- (void)testRunner {
    
    //[self testnetwork];
    NSLog(@"#### 8.0.0 Welcome to EasyClick ipa process, website: http://ieasyclick.com #####");
    FBWebServer *webServer = [[FBWebServer alloc] init];
    // 动态设置端口 也可以通过setAgentPort函数
    //[webServer setPort:19025];
    //[webServer setServerScreenPort:1888];
    //[webServer setServerScreenToggle:2];
    webServer.delegate = self;
    [webServer startServing];
}




#pragma mark - FBWebServerDelegate

- (void)webServerDidRequestShutdown:(FBWebServer *)webServer {
    [webServer stopServing];
}

@end
