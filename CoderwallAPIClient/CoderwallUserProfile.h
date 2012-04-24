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

@property (nonatomic, readonly) NSString *username;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSUInteger endorsements;
@property (nonatomic, readonly) NSDictionary *accounts;
@property (nonatomic, readonly) NSArray *badges;

@end
