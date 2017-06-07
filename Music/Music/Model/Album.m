#import "Album.h"

@implementation Album

#pragma mark - Object Life Cycle

- (instancetype)initWithName:(nonnull NSString *)name
                  artistName:(nonnull NSString *)artistName
                          ID:(int32_t)ID
                 releaseDate:(nonnull NSString *)releaseDate
              numberOfTracks:(int32_t)numberOfTracks
                       genre:(nonnull NSString *)genre
                       price:(float_t)price
                     country:(nonnull NSString *)country
                 explictness:(nonnull NSString *)explicitness
                    artistID:(int32_t)artistID
{

    self = [super init];
    if (self) {
        _name = name;
        _artistName = artistName;
        _ID = ID;
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
    return [[NSString alloc] initWithFormat:@"Album: %@, Artist: %@, AlbumID: %d, "
                                                "Release Date: %@, Number of Tracks: %d, Genre: %@, Price: %f, Country of Origin: %@, Explicit: %@, Artist ID: %d",
                                            _name,
                                            _artistName,
                                            _ID,
                                            _releaseDate,
                                            _numberOfTracks,
                                            _genre,
                                            _price,
                                            _country,
                                            _explicitness,
                                            _artistID];
}

@end