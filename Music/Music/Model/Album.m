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

- (instancetype)initWithDictionary:(nonnull NSDictionary<NSString *, id> *)albumDictionary
{
    self = [super init];
    if (self) {
        _name = [albumDictionary objectForKey:@"collectionName"];
        _artistName = [albumDictionary objectForKey:@"artistName"];
        _albumID = [[albumDictionary objectForKey:@"collectionId"] intValue];
        _releaseDate = [Album formatDate:[albumDictionary objectForKey:@"releaseDate"]];
        _numberOfTracks = [[albumDictionary objectForKey:@"trackCount"] intValue];
        _genre = [albumDictionary objectForKey:@"primaryGenreName"];
        _price = [[albumDictionary objectForKey:@"collectionPrice"] floatValue];
        _country = [albumDictionary objectForKey:@"country"];
        _explicitness = [albumDictionary objectForKey:@"collectionExplicitness"];
        _artistID = [[albumDictionary objectForKey:@"artistId"] intValue];
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

+ (nonnull NSDate *)formatDate:(NSString *)JSONString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *date = [dateFormatter dateFromString:JSONString];
    return date;
}

@end
