coderwallAPIClient
==================

coderwall API Objective-C client

Usage
----
load coderwall profile asynchronously.

    [[CoderwallAPIClient sharedClient] profileForUsername:@"coderwall username"
                                               completion:^(CoderwallUserProfile *profile){
                                                   // success
                                               }
                                                  failure:^(NSError *error){
                                                      // failure
                                                  }];

See CoderwallAPIClientExample application.

Requirements
----
AFNetworking - https://github.com/AFNetworking/AFNetworking

LICENSE
----
New BSD License. See LICENSE file.
