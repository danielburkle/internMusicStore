#import "Album.h"

@implementation Album

- (instancetype)initWithAlbumName:(NSString *)albumName
                 albumArtist:(NSString *)name
                     albumID:(int)ID
                 releaseDate:(NSString *)date
              numberOfTracks:(int)number
                       genre:(NSString *)genre
                       price:(NSString *)price
                     country:(NSString *)country
                 explictness:(NSString *)explicit
{

    self = [super init];
    if (self){
        _albumName = albumName;
        _albumArtist = name;
        _albumID = ID;
        _releaseDate = date;
        _numberOfTracks = number;
        _genre = genre;
        _price = price;
        _country = country;
        _explicitness = explicit;
    }
    return self;
}

- (NSString *)description{
    return [[NSString alloc] initWithFormat:@"Album: %@, Artist: %@, AlbumID: %d, "
        "Release Date: %@, Number of Tracks: %d, Genre: %@, Price: %@, Country of Origin: %@, Explicit: %@",
                                                    _albumName,
                                                    _albumArtist,
                                                    _albumID,
                                                    _releaseDate,
                                                    _numberOfTracks,
                                                    _genre,
                                                    _price,
                                                    _country,
                                                    _explicitness];
}

@end