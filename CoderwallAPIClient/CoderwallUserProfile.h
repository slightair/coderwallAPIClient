//
//  CoderwallUserProfile.h
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/23.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoderwallUserProfile : NSObject

+ (id)profileWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly, strong) NSString *username;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *location;
@property (nonatomic, readonly) NSUInteger endorsements;
@property (nonatomic, readonly, strong) NSDictionary *accounts;
@property (nonatomic, readonly, strong) NSArray *badges;

@end
