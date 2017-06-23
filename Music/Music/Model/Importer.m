//
// Created by Daniel Burkle on 6/2/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "Importer.h"

@implementation Importer

#pragma mark -JSON Processing

+ (nonnull NSArray<Album *> *)buildAlbumsFromJson
{
    return [Importer initializeAlbums:[Importer albumResultsFromDictionary:[Importer albumDictionary]]];
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

+ (nonnull NSArray<Album *> *)initializeAlbums:(nonnull NSArray <NSDictionary<NSString *, id > *> *)dictionaryArray
{
    NSMutableArray<Album *> *albums = [[NSMutableArray alloc] init];
    for (NSDictionary <NSString *, id> *albumDictionary in dictionaryArray) {
        Album *album = [[Album alloc] initWithDictionary:albumDictionary];
        [albums addObject:album];
    }
    return [albums copy];
}

+ (void)printAlbums:(nonnull NSArray<Album *> *)albums
{
    for (Album *album in albums) {
        NSLog(@"%@", [album description]);
    }
}

+ (nonnull NSArray<Track *> *)buildTracksFromJson
{
    return [Importer initializeTracks:[Importer trackResultsFromDictionary:[Importer trackDictionary]]];
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

+ (nonnull NSArray<Track *> *)initializeTracks:(nonnull NSArray <NSDictionary<NSString *, id > *> *)dictionaryArray
{
    NSMutableArray<Track *> *tracks = [[NSMutableArray alloc] init];
    for (NSDictionary <NSString *, id> *trackDictionary in dictionaryArray) {
        Track *track = [[Track alloc] initWithDictionary:trackDictionary];
        [tracks addObject:track];
    }
    return [tracks copy];
}

+ (void)printTracks:(nonnull NSArray<Track *> *)tracks
{
    for (Track *track in tracks) {
        NSLog(@"%@", [track description]);
    }
}

@end
