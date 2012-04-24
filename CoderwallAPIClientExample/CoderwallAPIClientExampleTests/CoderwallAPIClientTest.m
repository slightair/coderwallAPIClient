//
//  CoderwallAPIClientTest.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/23.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#define kStubServerPort 12345

#import <objc/objc-runtime.h>
#import "CoderwallAPIClientTest.h"
#import "CoderwallAPIClient.h"

@implementation CoderwallAPIClientTest
{
    NLTHTTPStubServer *stubServer_;
}

- (void)setUpClass
{
    [NLTHTTPStubServer globalSettings].port = kStubServerPort;
    
    stubServer_ = [NLTHTTPStubServer stubServer];
    [stubServer_ startServer];
}

- (void)tearDownClass {
    [stubServer_ stopServer];
}

- (void)setUp {
    [stubServer_ clear];
}

- (void)tearDown {
    if(![stubServer_ isStubEmpty]) {
        GHFail(@"stubs not empty");
    }
}

- (void)testAPIClientBaseURL
{
    NSURL *expectURL = [NSURL URLWithString:@"http://coderwall.com/"];
    GHAssertEqualObjects(expectURL, [[CoderwallAPIClient sharedClient] baseURL], @"baseURL should equal to %@", expectURL);
}

- (void)testProfileAPISuccess
{
    NLTHTTPStubResponse *stubResponse = [NLTHTTPStubResponse httpFileResponse];
    stubResponse.path = @"/slightair.json";
    stubResponse.filepath = [[NSBundle bundleForClass:[self class]] pathForResource:@"slightair" ofType:@"json"];
    stubResponse.httpHeaders = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"application/json; charset=utf-8", @"Content-Type",
                                nil];
    [stubServer_ addStubResponse:stubResponse];
    
    NSURL *stubServerBaseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:%d", kStubServerPort]];
    CoderwallAPIClient *client = (CoderwallAPIClient *)[CoderwallAPIClient clientWithBaseURL:stubServerBaseURL];
    
    [self prepare];
    [client profileForUsername:@"slightair"
                    completion:^(CoderwallUserProfile *profile){
                        NSString *expectUsername = @"slightair";
                        GHAssertEqualObjects(expectUsername, profile.username, @"profile.username should equal %@", expectUsername);
                        
                        [self notify:kGHUnitWaitStatusSuccess];
                    }
                       failure:^(NSError *error){
                           [self notify:kGHUnitWaitStatusFailure];
                       }];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:5.0f];
}

@end
