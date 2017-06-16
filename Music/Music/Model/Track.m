//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "Track.h"

@implementation Track

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithDictionary:(nonnull NSDictionary <NSString *, id> *)trackDictionary
{
    self = [super init];
    if (self) {
        _name = [trackDictionary objectForKey:@"trackName"];
        _artistName = [trackDictionary objectForKey:@"artistName"];
        _albumName = [trackDictionary objectForKey:@"collectionName"];
        _price = [[trackDictionary objectForKey:@"trackPrice"] floatValue];
        _trackNumber = [[trackDictionary objectForKey:@"trackNumber"] intValue];
        _diskNumber = [[trackDictionary objectForKey:@"discNumber"] intValue];
        _duration = [[trackDictionary objectForKey:@"trackTimeMillis"] intValue];
        _genre = [trackDictionary objectForKey:@"primaryGenreName"];
        _explicitness = [trackDictionary objectForKey:@"trackExplicitness"];
        _albumID = [[trackDictionary objectForKey:@"collectionId"] intValue];
        _artistID = [[trackDictionary objectForKey:@"artistId"] intValue];
        _country = [trackDictionary objectForKey:@"country"];
        _diskCount = [[trackDictionary objectForKey:@"discCount"] intValue];
        _trackID = [[trackDictionary objectForKey:@"trackId"] intValue];
    }
    return self;
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"Track: %@, Artist: %@, Album: %@, Price: %f,"
                                                                       "Track Number: %d, Disk Number: %d, Track Duration: %d, Genre: %@, Explicit: %@, AlbumID: %d, ArtistID: %d,"
                                                                       "Country: %@, Disk Count: %d, TrackID: %d",
                                                                   _name,
                                                                   _artistName,
                                                                   _albumName,
                                                                   _price,
                                                                   _trackNumber,
                                                                   _diskNumber,
                                                                   _duration,
                                                                   _genre,
                                                                   _explicitness,
                                                                   _albumID,
                                                                   _artistID,
                                                                   _country,
                                                                   _diskCount,
                                                                   _trackID];
    return descriptionString;
}

@end
