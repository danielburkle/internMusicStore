//
// Created by Daniel Burkle on 7/17/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCImporter.h"

#import "SCCAlbum.h"
#import "SCCTrack.h"
#import "SCCArtist.h"

static NSString *const SCCImporterResults = @"results";
static NSString *const SCCImporterKind = @"kind";
static NSString *const SCCImporterSong = @"song";

@implementation SCCImporter

#pragma mark - Importing Methods

+ (NSArray<id> *)entityFromPath:(NSString *)path error:(NSError **)error entityType:(NSString *)entityType
{
    return [self resultsFromJSON:[self jsonFromPath:path error:error] entityType:entityType];
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

+ (nullable NSArray<id> *)resultsFromJSON:(nonnull NSDictionary<NSString *, NSArray *> *)json entityType:(nonnull NSString *)entityType
{
    NSArray<NSDictionary<NSString *, id> *> *results = [json objectForKey:SCCImporterResults];
    if (results == nil) {
        return nil;
    } else if ([entityType isEqualToString:NSStringFromClass([SCCTrack class])]) {
        return [self tracksFromResults:results];
    } else {
        return [self albumsFromResults:results];
    }
}

#pragma mark - Object Array Builders

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

+ (nonnull NSArray<SCCArtist *> *)artistsFromResults:(nonnull NSArray<NSDictionary <NSString *, id> *> *)results
{
    NSMutableArray <SCCArtist *> *artists = [[NSMutableArray alloc] initWithCapacity:[results count]];
    for (NSDictionary<NSString *, id> *result in results) {
        [artists addObject:[[SCCArtist alloc] initWithDictionary:result]];
    }
    return [artists copy];
}

#pragma mark - Hard Coded JSON methods

+ (nonnull NSArray <NSDictionary <NSString *, id> *> *)resultsFromLocalArtistJSON
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"ArtistJSON" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSDictionary<NSString *, NSArray<NSDictionary <NSString *, id>*> *>  *fileContents = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return [[NSArray alloc] initWithArray:[fileContents objectForKey:@"results"]];
}

+ (void)printDescriptionsFromArtists:(nonnull NSArray<SCCArtist *> *)artists
{
    for (SCCArtist *artist in artists) {
        NSLog(@"%@", [artist description]);
    }
}

+ (void)configureArtistsForPrinting
{
    [self printDescriptionsFromArtists:[self artistsFromResults:[self resultsFromLocalArtistJSON]]];
}

@end
