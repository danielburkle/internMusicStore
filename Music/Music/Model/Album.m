//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "Album.h"

@implementation Album

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithName:(NSString *)name
                  artistName:(NSString *)artistName
                     albumID:(int32_t)albumID
                 releaseDate:(NSString *)releaseDate
              numberOfTracks:(int32_t)numberOfTracks
                       genre:(NSString *)genre
                       price:(float_t)price
                     country:(NSString *)country
                 explictness:(NSString *)explicitness
                    artistID:(int32_t)artistID
{

    self = [super init];
    if (self) {
        _name = name;
        _artistName = artistName;
        _albumID = albumID;
        _releaseDate = releaseDate;
        _numberOfTracks = numberOfTracks;
        _genre = genre;
        _price = price;
        _country = country;
        _explicitness = explicitness;
        _artistID = artistID;
    }
    return self;
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"Album: %@, Artist: %@, AlbumID: %d, Release Date: %@, Number of Tracks: %d, Genre: %@, Price: %f, Country of Origin: %@, Explicit: %@, artistID: %d",
                                            _name,
                                            _artistName,
                                            _albumID,
                                            _releaseDate,
                                            _numberOfTracks,
                                            _genre,
                                            _price,
                                            _country,
                                            _explicitness,
                                            _artistID];
}

@end