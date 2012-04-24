//
//  GCDSingleton.h
//  nicosega
//
//  Created by slightair on 11/12/02.
//  Copyright 2011 slightair. All rights reserved.
//

// Macro for creating your "shared instance" using GCD
// https://gist.github.com/1057420

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
    static dispatch_once_t pred = 0; \
    __strong static id _sharedObject = nil; \
    dispatch_once(&pred, ^{ \
        _sharedObject = block(); \
    }); \
    return _sharedObject; \
