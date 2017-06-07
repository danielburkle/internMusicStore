#import "Album.h"

@implementation Album

#pragma mark - Object Life Cycle

- (instancetype)initWithAlbumName:(nonnull NSString *)albumName
                      albumArtist:(nonnull NSString *)name
                          albumID:(int32_t)ID
                      releaseDate:(nonnull NSString *)date
                   numberOfTracks:(int32_t)number
                            genre:(nonnull NSString *)genre
                            price:(float_t)price
                          country:(nonnull NSString *)country
                      explictness:(nonnull NSString *)explicit
                         artistID:(int32_t)artistID
{

    self = [super init];
    if (self) {
        _albumName = albumName;
        _albumArtist = name;
        _albumID = ID;
        _releaseDate = date;
        _numberOfTracks = number;
        _genre = genre;
        _price = price;
        _country = country;
        _explicitness = explicit;
        _artistID = artistID;
    }
    return self;
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"Album: %@, Artist: %@, AlbumID: %d, "
                                                "Release Date: %@, Number of Tracks: %d, Genre: %@, Price: %f, Country of Origin: %@, Explicit: %@, Artist ID: %d",
                                            _albumName,
                                            _albumArtist,
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