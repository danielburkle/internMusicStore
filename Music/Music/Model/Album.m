//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "Album.h"

@implementation Album

static NSString *const AlbumArtistName = @"artistName";
static NSString *const AlbumCollectionID = @"collectionId";
static NSString *const AlbumCollectionName = @"collectionName";
static NSString *const AlbumCollectionPrice = @"collectionPrice";
static NSString *const AlbumCountry = @"country";
static NSString *const AlbumExplicitness = @"collectionExplicitness";
static NSString *const AlbumGenreName = @"primaryGenreName";
static NSString *const AlbumReleaseDate = @"releaseDate";
static NSString *const AlbumTrackCount = @"trackCount";

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
{
    self = [super init];
    if (self) {
        _name = [dictionary objectForKey:AlbumCollectionName];
        _albumID = [[dictionary objectForKey:AlbumCollectionID] intValue];
        _artistName = [dictionary objectForKey:AlbumArtistName];
        _country = [dictionary objectForKey:AlbumCountry];
        _explicitness = [dictionary objectForKey:AlbumExplicitness];
        _genre = [dictionary objectForKey:AlbumGenreName];
        _numberOfTracks = [[dictionary objectForKey:AlbumTrackCount] intValue];
        _price = [[dictionary objectForKey:AlbumCollectionPrice] floatValue];
        _releaseDate = [Album formatJSONDate:[dictionary objectForKey:AlbumReleaseDate]];
    }
    return self;
}

#pragma mark - NSObject Implementation

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

#pragma mark - String Formatting

+ (nonnull NSDate *)formatJSONDate:(nonnull NSString *)JSONDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *date = [dateFormatter dateFromString:JSONDate];
    return date;
}

@end
