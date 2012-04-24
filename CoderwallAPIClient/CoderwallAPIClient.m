//
//  CoderwallAPIClient.m
//  CoderwallAPIClientExample
//
//  Created by slightair on 12/04/23.
//  Copyright (c) 2012 slightair. All rights reserved.
//

#define kCoderwallAPIBaseURL @"http://coderwall.com/"

#import "GCDSingleton.h"
#import "CoderwallAPIClient.h"

@implementation CoderwallAPIClient

+ (id)sharedClient
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:kCoderwallAPIBaseURL]];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)profileForUsername:(NSString *)username
                completion:(CoderwallAPIProfileSuccessBlock)completion
                   failure:(CoderwallAPIBasicFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:@"GET"
                                                      path:[NSString stringWithFormat:@"/%@.json", username]
                                                parameters:nil];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            CoderwallUserProfile *profile = [CoderwallUserProfile profileWithDictionary:JSON];
                                                                                            
                                                                                            completion(profile);
                                                                                        }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
                                                                                            failure(error);
                                                                                        }];
    [operation start];
}

@end
