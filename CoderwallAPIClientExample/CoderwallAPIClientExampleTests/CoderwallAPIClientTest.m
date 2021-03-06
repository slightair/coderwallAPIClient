//
//  CoderwallAPIClientTest.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/23.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#define kStubServerPort 12345

#import "NLTHTTPStubServer.h"
#import "CoderwallAPIClientTest.h"
#import "CoderwallAPIClient.h"

@implementation CoderwallAPIClientTest
{
    NLTHTTPStubServer *stubServer_;
    NSURL *stubServerBaseURL_;
}

- (void)setUpClass
{
    [NLTHTTPStubServer globalSettings].port = kStubServerPort;
    
    stubServer_ = [NLTHTTPStubServer stubServer];
    [stubServer_ startServer];
    
    stubServerBaseURL_ = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:%d", kStubServerPort]];
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
    GHAssertEqualObjects([[CoderwallAPIClient sharedClient] baseURL], expectURL, @"baseURL should equal to %@", expectURL);
}

- (void)testProfileAPISuccess
{
    NSData *successJSON = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"slightair" ofType:@"json"]];
    [[[[stubServer_ stub] forPath:@"/slightair.json"] andJSONResponse:successJSON] andStatusCode:200];
    
    CoderwallAPIClient *client = (CoderwallAPIClient *)[CoderwallAPIClient clientWithBaseURL:stubServerBaseURL_];
    
    [self prepare];
    [client profileForUsername:@"slightair"
                    completion:^(CoderwallUserProfile *profile){
                        
                        NSString *expectUsername = @"slightair";
                        NSString *expectName = @"Tomohiro Moro";
                        NSString *expectLocation = @"Tokyo";
                        NSUInteger expectEndorsements = 3;
                        NSDictionary *expectAccounts = [NSDictionary dictionaryWithObject:@"slightair" forKey:@"github"];
                        NSUInteger expectNumberOfBadges = 8;
                        
                        GHAssertEqualStrings(profile.username, expectUsername, @"profile.username should equal to %@", expectUsername);
                        GHAssertEqualStrings(profile.name, expectName, @"profile.name should equal to %@", expectName);
                        GHAssertEqualStrings(profile.location, expectLocation, @"profile.location should equal to %@", expectLocation);
                        GHAssertEquals(profile.endorsements, expectEndorsements, @"profile.endorsements should equal to %u", expectEndorsements);
                        GHAssertEqualObjects(profile.accounts, expectAccounts, @"profile.accounts should equal to %@", expectAccounts);
                        GHAssertEquals([profile.badges count], expectNumberOfBadges, @"profile.badges count should equal to %u", expectNumberOfBadges);
                        
                        [self notify:kGHUnitWaitStatusSuccess];
                    }
                       failure:^(NSError *error){
                           [self notify:kGHUnitWaitStatusFailure];
                       }];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:5.0f];
}

- (void)testProfileAPIFailure
{
    NSData *failureJSON = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"slightair" ofType:@"json"]];
    [[[[stubServer_ stub] forPath:@"/hogehogehoge.json"] andJSONResponse:failureJSON] andStatusCode:404];
    
    CoderwallAPIClient *client = (CoderwallAPIClient *)[CoderwallAPIClient clientWithBaseURL:stubServerBaseURL_];
    
    [self prepare];
    [client profileForUsername:@"hogehogehoge"
                    completion:^(CoderwallUserProfile *profile){
                        [self notify:kGHUnitWaitStatusFailure];
                    }
                       failure:^(NSError *error){
                           GHAssertNotNil(error, @"should return error");
                           
                           [self notify:kGHUnitWaitStatusSuccess];
                       }];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:5.0f];
}

@end
