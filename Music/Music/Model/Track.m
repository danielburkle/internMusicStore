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

- (instancetype)initWithName:(NSString *)name
                  artistName:(NSString *)artistName
                   albumName:(nonnull NSString *)albumName
                       price:(float_t)price
                 trackNumber:(int32_t)trackNumber
                  diskNumber:(int32_t)diskNumber
                    duration:(int32_t)duration
                       genre:(NSString *)genre
                 explictness:(NSString *)explicitness
                     albumID:(int32_t)albumID
                    artistID:(int32_t)artistID
                     country:(NSString *)country
                   diskCount:(int32_t)diskCount
                     trackID:(int32_t)trackID
{

    self = [super init];
    if (self) {
        _name = name;
        _artistName = artistName;
        _albumName = albumName;
        _price = price;
        _trackNumber = trackNumber;
        _diskNumber = diskNumber;
        _duration = duration;
        _genre = genre;
        _explicitness = explicitness;
        _albumID = albumID;
        _artistID = artistID;
        _country = country;
        _diskCount = diskCount;
        _trackID = trackID;
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