//
//  CoderwallAPIClient.h
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/23.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "CoderwallUserProfile.h"
#import "CoderwallBadge.h"

typedef void (^CoderwallAPIProfileSuccessBlock)(CoderwallUserProfile *profile);
typedef void (^CoderwallAPIBasicFailureBlock)(NSError *error);

@interface CoderwallAPIClient : AFHTTPClient

+ (id)sharedClient;
- (void)profileForUsername:(NSString *)username
                completion:(CoderwallAPIProfileSuccessBlock)completion
                   failure:(CoderwallAPIBasicFailureBlock)failure;

@end
