//
//  CoderwallBadge.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/24.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import "CoderwallBadge.h"

@interface CoderwallBadge ()

@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *description;
@property (nonatomic, readwrite, strong) NSDate *created;
@property (nonatomic, readwrite, strong) NSURL *badge;

@end

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
        
        self.name        = [dictionary objectForKey:@"name"];
        self.description = [dictionary objectForKey:@"description"];
        self.created     = [dateFormatter dateFromString:[dictionary objectForKey:@"created"]];
        self.badge       = [NSURL URLWithString:[dictionary objectForKey:@"badge"]];
    }
    return self;
}

@end
