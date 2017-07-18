//
// Created by Daniel Burkle on 7/12/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCPerformSearchOperation.h"

#import "SCCAlbum.h"
#import "SCCTrack.h"
#import "SCCImporter.h"

@interface SCCPerformSearchOperation () {
    NSString *_searchCriteria;
    NSString *_entityType;
}
@end

static NSString *const SCCPerformSearchOperationAlbumRootURL = @"https://itunes.apple.com/search?term=";
static NSString *const SCCPerformSearchOperationAlbumEntitySuffix = @"&entity=album";
static NSString *const SCCPerformSearchOperationResultLimit = @"&limit=25";
static NSString *const SCCPerformSearchOperationTrackRootURL = @"https://itunes.apple.com/lookup?id=";
static NSString *const SCCPerformSearchOperationTrackEntitySuffix = @"&entity=song";

#pragma mark - Object Life Cycle

@implementation SCCPerformSearchOperation

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithSearchCriteria:(NSString *)searchCriteria entityType:(NSString *)entityType
{
    self = [super init];
    if (self) {
        _searchCriteria = searchCriteria;
        _entityType = entityType;
    }
    return self;
}

#pragma mark - NSOperation

- (void)main
{
    if (![self isCancelled]) {
        NSError *error = nil;
        NSArray<id> *results = [SCCImporter entityFromPath:[self entityURLFromSearchTerms:_searchCriteria] error:&error];
        _operationCompletion(results, error);
    }
}

#pragma mark - API URL Formatting

- (nonnull NSString *)entityURLFromSearchTerms:(nonnull NSString *)searchTerms
{
    if ([_entityType isEqualToString:NSStringFromClass([SCCAlbum class])]) {
        NSArray<NSString *> *individualSearchTerms = [searchTerms componentsSeparatedByString:@" "];
        NSString *albumBaseURL = [[NSString alloc] initWithFormat:SCCPerformSearchOperationAlbumRootURL];
        NSString *formattedSearchTerms = [individualSearchTerms componentsJoinedByString:@"+"];
        NSString *albumEntity = [[NSString alloc] initWithFormat:SCCPerformSearchOperationAlbumEntitySuffix];
        NSString *albumResultLimit = [[NSString alloc] initWithFormat:SCCPerformSearchOperationResultLimit];
        return [[NSString alloc] initWithFormat:@"%@%@%@%@", albumBaseURL, formattedSearchTerms, albumEntity, albumResultLimit];
    } else if ([_entityType isEqualToString:NSStringFromClass([SCCTrack class])]) {
        NSString *trackBaseURL = [[NSString alloc] initWithFormat:SCCPerformSearchOperationTrackRootURL];
        NSString *formattedSearchTerms = searchTerms;
        NSString *trackEntity = [[NSString alloc] initWithFormat:SCCPerformSearchOperationTrackEntitySuffix];
        return [[NSString alloc] initWithFormat:@"%@%@%@", trackBaseURL, formattedSearchTerms, trackEntity];
    } else {
        NSLog(@"This type is not supported by entityURLFromSearchTerms");
        abort();
    }
}

@end