//
//  CoderwallUserProfile.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/23.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import "CoderwallUserProfile.h"
#import "CoderwallBadge.h"

@implementation CoderwallUserProfile

@synthesize username = username_;
@synthesize name = name_;
@synthesize location = location_;
@synthesize endorsements = endorsements_;
@synthesize accounts = accounts_;
@synthesize badges = badges_;

+ (id)profileWithDictionary:(NSDictionary *)dictionary
{
    return [[CoderwallUserProfile alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        username_     = [dictionary objectForKey:@"username"];
        name_         = [dictionary objectForKey:@"name"];
        location_     = [dictionary objectForKey:@"location"];
        endorsements_ = [[dictionary objectForKey:@"endorsements"] unsignedIntegerValue];
        accounts_     = [dictionary objectForKey:@"accounts"];
        
        NSMutableArray *badges = [NSMutableArray array];
        for (NSDictionary *badgeInfo in [dictionary objectForKey:@"badges"]) {
            [badges addObject:[CoderwallBadge badgeWithDictionary:badgeInfo]];
        }
        badges_ = [NSArray arrayWithArray:badges];
    }
    return self;
}

@end
