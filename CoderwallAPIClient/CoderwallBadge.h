//
//  CoderwallBadge.h
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/24.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoderwallBadge : NSObject

+ (id)badgeWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *description;
@property (nonatomic, readonly, strong) NSDate *created;
@property (nonatomic, readonly, strong) NSURL *badge;

@end
