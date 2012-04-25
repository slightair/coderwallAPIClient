//
//  CoderwallUserProfile.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/23.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import "CoderwallUserProfile.h"
#import "CoderwallBadge.h"

@interface CoderwallUserProfile ()

@property (nonatomic, readwrite, strong) NSString *username;
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *location;
@property (nonatomic, readwrite) NSUInteger endorsements;
@property (nonatomic, readwrite, strong) NSDictionary *accounts;
@property (nonatomic, readwrite, strong) NSArray *badges;

@end

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
        self.username     = [dictionary objectForKey:@"username"];
        self.name         = [dictionary objectForKey:@"name"];
        self.location     = [dictionary objectForKey:@"location"];
        self.endorsements = [[dictionary objectForKey:@"endorsements"] unsignedIntegerValue];
        self.accounts     = [dictionary objectForKey:@"accounts"];
        
        NSMutableArray *badges = [NSMutableArray array];
        for (NSDictionary *badgeInfo in [dictionary objectForKey:@"badges"]) {
            [badges addObject:[CoderwallBadge badgeWithDictionary:badgeInfo]];
        }
        self.badges = [NSArray arrayWithArray:badges];
    }
    return self;
}

@end
