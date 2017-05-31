#import "Album.h"

@implementation Album

- (instancetype)initWithJSON:(NSString *)albumName
                 albumArtist:(NSString *)name
                     albumID:(int)ID
                 releaseDate:(NSString *)date
              numberOfTracks:(int)number
                       genre:(NSString *)genre
                       price:(NSString *)price
                     country:(NSString *)country
                 explictness:(NSString *)explicit{

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
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"Album: %@, Artist: %@, AlbumID: %d, "
        "Release Date: %@, Number of Tracks: %d, Genre: %@, Price: %@, Country of Origin: %@, Explicit: %@",
                                                    [self albumName],
                                                    [self albumArtist],
                                                    [self albumID],
                                                    [self releaseDate],
                                                    [self numberOfTracks],
                                                    [self genre],
                                                    [self price],
                                                    [self country],
                                                    [self explicitness]];
    return descriptionString;
}

@end