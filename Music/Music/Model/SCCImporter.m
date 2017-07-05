//
// Created by Daniel Burkle on 6/2/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCImporter.h"

@implementation SCCImporter

#pragma mark -JSON Processing

+ (nonnull NSArray<SCCAlbum *> *)buildAlbumsFromJson
{
    return [SCCImporter initializeAlbums:[SCCImporter albumResultsFromDictionary:[SCCImporter albumDictionary]]];
}

+ (nonnull NSDictionary<NSString *, id> *)albumDictionary
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"AlbumResults" ofType:@"json"];
    NSData *fileContents = [[NSData alloc] initWithContentsOfFile:filepath];

    NSError *jsonError;
    NSDictionary<NSString *, id> *parsedJsonDictionary = [NSJSONSerialization JSONObjectWithData:fileContents options:NSJSONReadingMutableContainers error:&jsonError];
    if (parsedJsonDictionary == nil) {
        NSLog(@"Error reading album NSData: %@", [jsonError localizedDescription]);
        return [[NSDictionary alloc] init];
    }
    return parsedJsonDictionary;
}

+ (nonnull NSArray<NSDictionary <NSString *, id> *> *)albumResultsFromDictionary:(nonnull NSDictionary<NSString *, id> *)dictionary
{
    return [[NSArray alloc] initWithArray:[dictionary objectForKey:@"results"]];
}

+ (nonnull NSArray<SCCAlbum *> *)initializeAlbums:(nonnull NSArray <NSDictionary<NSString *, id > *> *)dictionaryArray
{
    NSMutableArray<SCCAlbum *> *albums = [[NSMutableArray alloc] init];
    for (NSDictionary <NSString *, id> *albumDictionary in dictionaryArray) {
        SCCAlbum *album = [[SCCAlbum alloc] initWithDictionary:albumDictionary];
        [albums addObject:album];
    }
    return [albums copy];
}

+ (void)printAlbums:(nonnull NSArray<SCCAlbum *> *)albums
{
    for (SCCAlbum *album in albums) {
        NSLog(@"%@", [album description]);
    }
}

+ (nonnull NSArray<SCCTrack *> *)buildTracksFromJson
{
    return [SCCImporter initializeTracks:[SCCImporter trackResultsFromDictionary:[SCCImporter trackDictionary]]];
}

+ (nonnull NSDictionary<NSString *, id> *)trackDictionary
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"TrackResults" ofType:@"json"];
    NSData *fileContents = [[NSData alloc] initWithContentsOfFile:filepath];
    NSError *jsonError;
    NSDictionary<NSString *, id> *parsedJsonDictionary = [NSJSONSerialization JSONObjectWithData:fileContents options:NSJSONReadingMutableContainers error:&jsonError];
    if (parsedJsonDictionary == nil) {
        NSLog(@"Error reading track NSData: %@", [jsonError localizedDescription]);
        return [[NSDictionary alloc] init];
    }
    return parsedJsonDictionary;
}

+ (nonnull NSArray<NSDictionary <NSString *, id> *> *)trackResultsFromDictionary:(nonnull NSDictionary<NSString *, id> *)JsonDictionary
{
    return [[NSArray alloc] initWithArray:[JsonDictionary objectForKey:@"results"]];
}

+ (nonnull NSArray<SCCTrack *> *)initializeTracks:(nonnull NSArray <NSDictionary<NSString *, id > *> *)dictionaryArray
{
    NSMutableArray<SCCTrack *> *tracks = [[NSMutableArray alloc] init];
    for (NSDictionary <NSString *, id> *trackDictionary in dictionaryArray) {
        SCCTrack *track = [[SCCTrack alloc] initWithDictionary:trackDictionary];
        [tracks addObject:track];
    }
    return [tracks copy];
}

+ (void)printTracks:(nonnull NSArray<SCCTrack *> *)tracks
{
    for (SCCTrack *track in tracks) {
        NSLog(@"%@", [track description]);
    }
}

@end
