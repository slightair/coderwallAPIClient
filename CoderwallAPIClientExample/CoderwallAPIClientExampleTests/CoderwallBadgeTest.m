//
//  CoderwallBadgeTest.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/24.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import "CoderwallBadgeTest.h"
#import "CoderwallBadge.h"

@implementation CoderwallBadgeTest

- (void)testInitWithDictionary
{
    NSString *expectName = @"Bear";
    NSString *expectDescription = @"Have at least one original repo where Objective-C is the dominant language";
    NSDate *expectCreated = [NSDate dateWithTimeIntervalSince1970:1333238400];
    NSURL *expectBadge = [NSURL URLWithString:@"http://cdn.coderwall.com/assets/badges/bear-77297682d72716ea4cf2f0789ba9a522.png"];
    
    NSDictionary *badgeInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               expectName, @"name",
                               expectDescription, @"description",
                               @"2012-04-01T00:00:00Z", @"created",
                               @"http://cdn.coderwall.com/assets/badges/bear-77297682d72716ea4cf2f0789ba9a522.png", @"badge",
                               nil];
    
    CoderwallBadge *badge = [CoderwallBadge badgeWithDictionary:badgeInfo];
    GHAssertEqualStrings(badge.name, expectName, @"badge.name should equal to %@", expectName);
    GHAssertEqualStrings(badge.description, expectDescription, @"badge.description should equal to %@", expectDescription);
    GHAssertEqualObjects(badge.created, expectCreated, @"badge.created should equal to %@", expectCreated);
    GHAssertEqualObjects(badge.badge, expectBadge, @"badge.badge should equal to %@", expectBadge);
}

@end
