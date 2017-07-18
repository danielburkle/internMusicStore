//
// Created by Daniel Burkle on 7/17/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCImporter.h"

#import "SCCAlbum.h"
#import "SCCTrack.h"

static NSString *const SCCImporterResults = @"results";
static NSString *const SCCImporterKind = @"kind";
static NSString *const SCCImporterSong = @"song";

@implementation SCCImporter

+ (NSArray<id> *)entityFromPath:(NSString *)path error:(NSError **)error
{
    return [self resultsFromJSON:[self jsonFromPath:path error:error]];
}

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
    NSArray<NSDictionary<NSString *, id> *> *results = [json objectForKey:SCCImporterResults];
    if (results == nil) {
        return nil;
    } else if ([[results[1] objectForKey:SCCImporterKind] isEqualToString:SCCImporterSong]) {
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
    NSMutableArray<SCCTrack *> *tracks = [[NSMutableArray alloc] initWithCapacity:[results count] - 1];
    for (NSUInteger i = 1; i < [results count]; i++) {
        [tracks addObject:[[SCCTrack alloc] initWithDictionary:results[i]]];
    }
    return [tracks copy];
}

@end