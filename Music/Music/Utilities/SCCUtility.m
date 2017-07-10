//
// Created by Daniel Burkle on 7/10/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCUtility.h"

@implementation SCCUtility

static NSString *const SCCHeaderDetailViewExplicit = @"Explicit";

#pragma mark - Utility Methods

+ (NSString *)formatExplicitness:(NSString *)explicitness
{
    if ([explicitness isEqualToString:SCCHeaderDetailViewExplicit]) {
        return [self localizedExplicit];
    } else {
        return [self localizedNotExplicit];
    }
}

+ (NSString *)formatDuration:(int32_t)duration
{
    long durationTotalSeconds = duration / 1000;
    long minutes = durationTotalSeconds / 60;
    if (minutes >= 60) {
        long hours = minutes / 60;
        long leftoverMinutes = minutes % 60;
        long seconds = lround(durationTotalSeconds % 60);
        return [NSString stringWithFormat:@"%lu:%lu:%02lu", hours, leftoverMinutes, seconds];
    }
    long seconds = lround(durationTotalSeconds) % 60;
    return [NSString stringWithFormat:@"%lu:%02lu", minutes, seconds];
}

#pragma mark - Localized Strings

+ (nonnull NSString *)localizedNotExplicit
{
    return @"Not Explicit";
}

+ (nonnull NSString *)localizedExplicit
{
    return @"Explicit";
}

@end