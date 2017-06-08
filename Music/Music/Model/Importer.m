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
        Album *albumToAdd = [[Album alloc] initWithName:[albumDictionary objectForKey:@"collectionName"]
                                             artistName:[albumDictionary objectForKey:@"artistName"]
                                                albumID:[[albumDictionary objectForKey:@"collectionId"] integerValue]
                                            releaseDate:[albumDictionary objectForKey:@"releaseDate"]
                                         numberOfTracks:[[albumDictionary objectForKey:@"trackCount"] integerValue]
                                                  genre:[albumDictionary objectForKey:@"primaryGenreName"]
                                                  price:[[albumDictionary objectForKey:@"collectionPrice"] floatValue]
                                                country:[albumDictionary objectForKey:@"country"]
                                            explictness:[albumDictionary objectForKey:@"collectionExplicitness"]
                                               artistID:[[albumDictionary objectForKey:@"artistId"] integerValue]];
        [albums addObject:albumToAdd];
    }
    return [albums copy];
}

+ (void)printAlbumDescription:(nonnull NSArray<Album *> *)albumArray
{
    for (Album *album in albumArray) {
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
        Track *trackToAdd = [[Track alloc] initWithName:[trackDictionary objectForKey:@"trackName"]
                                             artistName:[trackDictionary objectForKey:@"artistName"]
                                              albumName:[trackDictionary objectForKey:@"collectionName"]
                                                  price:[[trackDictionary objectForKey:@"trackPrice"] floatValue]
                                            trackNumber:[[trackDictionary objectForKey:@"trackNumber"] integerValue]
                                             diskNumber:[[trackDictionary objectForKey:@"discNumber"] integerValue]
                                               duration:[[trackDictionary objectForKey:@"trackTimeMillis"] integerValue]
                                                  genre:[trackDictionary objectForKey:@"primaryGenreName"]
                                            explictness:[trackDictionary objectForKey:@"trackExplicitness"]
                                                albumID:[[trackDictionary objectForKey:@"collectionId"] integerValue]
                                               artistID:[[trackDictionary objectForKey:@"artistId"] integerValue]
                                                country:[trackDictionary objectForKey:@"country"]
                                              diskCount:[[trackDictionary objectForKey:@"discCount"] integerValue]
                                                trackID:[[trackDictionary objectForKey:@"trackId"] integerValue]];
        [tracks addObject:trackToAdd];
    }
    return [tracks copy];
}

+ (void)printTrackDescription:(nonnull NSArray<Track *> *)trackArray
{
    for (Track *track in trackArray) {
        NSLog(@"%@", [track description]);
    }
}

@end
