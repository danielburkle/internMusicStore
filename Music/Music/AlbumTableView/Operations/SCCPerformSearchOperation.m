//
// Created by Daniel Burkle on 7/12/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCPerformSearchOperation.h"

#import "SCCAlbum.h"

@interface SCCPerformSearchOperation () {
    NSString *_searchCriteria;
}
@end

static NSString *const SCCPerformSearchOperationRootURL = @"https://itunes.apple.com/search?term=";
static NSString *const SCCPerformSearchOperationAlbumEntitySuffix = @"&entity=album";
static NSString *const SCCPerformSearchOperationResultLimit = @"&limit=25";

#pragma mark - Object Life Cycle

@implementation SCCPerformSearchOperation

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithSearchCriteria:(NSString *)searchCriteria
{
    self = [super init];
    if (self) {
        _searchCriteria = searchCriteria;
    }
    return self;
}

#pragma mark - NSOperation

- (void)main
{
    if (![self isCancelled]) {
        NSError *error = nil;
        NSDictionary<NSString *, NSArray *> *json = [SCCPerformSearchOperation jsonFromPath:[SCCPerformSearchOperation albumURLFromSearchTerms:_searchCriteria] error:&error];
        NSArray<SCCAlbum *> *results = [SCCPerformSearchOperation resultsFromJSON:json];
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

+ (nullable NSArray<SCCAlbum *> *)resultsFromJSON:(nonnull NSDictionary<NSString *, NSArray *> *)json
{
    NSArray<NSDictionary<NSString *, id> *> *results = [json objectForKey:@"results"];
    if (results == nil) {
        return nil;
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

#pragma mark - API URL Formatting

+ (nonnull NSString *)albumURLFromSearchTerms:(nonnull NSString *)searchTerms
{
    NSArray *individualSearchTerms = [searchTerms componentsSeparatedByString:@" "];
    NSString *albumBaseURL = [[NSString alloc] initWithFormat:SCCPerformSearchOperationRootURL];
    NSString *formattedSearchTerms = [individualSearchTerms componentsJoinedByString:@"+"];
    NSString *albumEntity = [[NSString alloc] initWithFormat:SCCPerformSearchOperationAlbumEntitySuffix];
    NSString *albumResultLimit = [[NSString alloc] initWithFormat:SCCPerformSearchOperationResultLimit];
    return [[NSString alloc] initWithFormat:@"%@%@%@%@", albumBaseURL, formattedSearchTerms, albumEntity, albumResultLimit];
}

@end