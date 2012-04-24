//
//  CoderwallUserProfileTest.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/24.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import "CoderwallUserProfileTest.h"
#import "CoderwallUserProfile.h"
#import "CoderwallBadge.h"

@implementation CoderwallUserProfileTest

- (void)testInitWithDictionary
{
    NSString *expectUsername = @"testUsername";
    NSString *expectName = @"testName";
    NSString *expectLocation = @"testLocation";
    NSUInteger expectEndorsements = 10;
    NSString *expectBadgeName = @"Bear";
    
    NSDictionary *badgeInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Bear", @"name",
                               @"Have at least one original repo where Objective-C is the dominant language", @"desctiption",
                               @"2012-04-01T00:00:00Z", @"created",
                               @"http://cdn.coderwall.com/assets/badges/bear-77297682d72716ea4cf2f0789ba9a522.png", @"badge",
                               nil];
    NSDictionary *profileInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 expectUsername, @"username",
                                 expectName, @"name",
                                 expectLocation, @"location",
                                 [NSNumber numberWithUnsignedInteger:expectEndorsements], @"endorsements",
                                 [NSDictionary dictionaryWithObject:expectUsername forKey:@"github"], @"accounts",
                                 [NSArray arrayWithObject:badgeInfo], @"badges",
                                 nil];
    
    CoderwallUserProfile *profile = [[CoderwallUserProfile alloc] initWithDictionary:profileInfo];
    GHAssertEqualStrings(profile.username, expectUsername, @"profile.username should equal to %@", expectUsername);
    GHAssertEqualStrings(profile.name, expectName, @"profile.name should equal to %@", expectName);
    GHAssertEqualStrings(profile.location, expectLocation, @"profile.location should equal to %@", expectLocation);
    GHAssertEquals(profile.endorsements, expectEndorsements, @"profile.endorsements should equal to %u", expectEndorsements);
    
    CoderwallBadge *badge = [profile.badges objectAtIndex:0];
    GHAssertEqualStrings(badge.name, expectBadgeName, @"badge.name should equal to %@", expectBadgeName);
}
                                     
@end
