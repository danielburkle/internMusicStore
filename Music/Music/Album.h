#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (readonly) NSString *albumName;
@property (readonly) NSString *albumArtist;
@property (readonly) int albumID;
@property (readonly) NSString *releaseDate;
@property (readonly) int numberOfTracks;
@property (readonly) NSString *genre;
@property (readonly) NSString *price;
@property (readonly) NSString *country;
@property (readonly) NSString *explicitness;


- (instancetype)initWithJSON:(NSString *)albumName
                 albumArtist:(NSString *)name
                     albumID:(int)ID
                 releaseDate:(NSString *)date
              numberOfTracks:(int)number
                       genre:(NSString *)genre
                       price:(NSString *)price
                     country:(NSString *)country
                 explictness:(NSString *)explicit;

@end