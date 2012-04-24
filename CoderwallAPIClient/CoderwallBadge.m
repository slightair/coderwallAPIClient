//
//  CoderwallBadge.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/24.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import "CoderwallBadge.h"

@implementation CoderwallBadge

@synthesize name = name_;
@synthesize description = description_;
@synthesize created = created_;
@synthesize badge = badge_;

+ (id)badgeWithDictionary:(NSDictionary *)dictionary
{
    return [[CoderwallBadge alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        
        name_        = [dictionary objectForKey:@"name"];
        description_ = [dictionary objectForKey:@"description"];
        created_     = [dateFormatter dateFromString:[dictionary objectForKey:@"created"]];
        badge_       = [NSURL URLWithString:[dictionary objectForKey:@"badge"]];
    }
    return self;
}

@end
