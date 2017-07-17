//
// Created by Daniel Burkle on 7/12/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCPerformSearchOperation.h"

#import "SCCAlbum.h"
#import "SCCTrack.h"

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
static NSString *const SCCPerformSearchOperationResults = @"results";
static NSString *const SCCPerformSearchOperationKind = @"kind";
static NSString *const SCCPerformSearchOperationSong = @"song";

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
        NSDictionary<NSString *, NSArray *> *json = [SCCPerformSearchOperation jsonFromPath:[self entityURLFromSearchTerms:_searchCriteria] error:&error];
        NSArray<id> *results = [SCCPerformSearchOperation resultsFromJSON:json];
        _operationCompletion(results, error);
    }
}

#pragma mark - Result Formatting

+ (nullable NSDictionary<NSString *, NSArray *> *)jsonFromPath:(nonnull NSString *)path error:(NSError **)error
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:path] options:kNilOptions error:error];
    if (data != nil) {
        return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
    } else {
        return nil;
    }
}

+ (nullable NSArray<id> *)resultsFromJSON:(nonnull NSDictionary<NSString *, NSArray *> *)json
{
    NSArray<NSDictionary<NSString *, id> *> *results = [json objectForKey:SCCPerformSearchOperationResults];
    if (results == nil) {
        return nil;
    } else if ([[results[1] objectForKey:SCCPerformSearchOperationKind] isEqualToString:SCCPerformSearchOperationSong]) {
        return [self tracksFromResults:results];
    } else {
        return [self albumsFromResults:results];
    }
}

+ (nonnull NSArray<SCCAlbum *> *)albumsFromResults:(nonnull NSArray<NSDictionary <NSString *, id> *> *)results
{
    NSMutableArray<SCCAlbum *> *albums = [[NSMutableArray alloc] initWithCapacity:[results count]];
    for (NSDictionary<NSString *, id> *result in results) {
        [albums addObject:[[SCCAlbum alloc] initWithDictionary:result]];
    }
    return [albums copy];
}

+ (nonnull NSArray<SCCTrack *> *)tracksFromResults:(nonnull NSArray<NSDictionary <NSString *, id> *> *)results
{
    NSMutableArray<SCCTrack *> *tracks = [[NSMutableArray alloc] initWithCapacity:[results count] - 1 ];
    for (NSUInteger i = 1; i < [results count]; i++) {
        [tracks addObject:[[SCCTrack alloc] initWithDictionary:results[i]]];
    }
    return [tracks copy];
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