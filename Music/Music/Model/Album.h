#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonnull, nonatomic, strong, readonly) NSString *albumName;
@property (nonnull, nonatomic, strong, readonly) NSString *albumArtist;
@property (nonatomic, readonly) int albumID;
@property (nonnull, nonatomic, strong, readonly) NSString *releaseDate;
@property (nonatomic, readonly) int numberOfTracks;
@property (nonnull, nonatomic, strong, readonly) NSString *genre;
@property (nonnull, nonatomic, strong, readonly) NSString *price;
@property (nonnull, nonatomic, strong, readonly) NSString *country;
@property (nonnull, nonatomic, strong, readonly) NSString *explicitness;


- (nonnull instancetype)initWithAlbumName:(nonnull NSString *)albumName
                 albumArtist:(nonnull NSString *)name
                     albumID:(int)ID
                 releaseDate:(nonnull NSString *)date
              numberOfTracks:(int)number
                       genre:(nonnull NSString *)genre
                       price:(nonnull NSString *)price
                     country:(nonnull NSString *)country
                 explictness:(nonnull NSString *)explicit
                NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end