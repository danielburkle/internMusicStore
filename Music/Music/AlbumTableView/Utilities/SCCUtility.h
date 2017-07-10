//
// Created by Daniel Burkle on 7/10/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@interface SCCUtility : NSObject

+ (nonnull NSString *)formatExplicitness:(nonnull NSString *)explicitness;

+ (nonnull NSString *)formatDuration:(int32_t)duration;

@end