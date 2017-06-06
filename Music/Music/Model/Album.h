#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonnull, nonatomic, strong, readonly) NSString *albumName;
@property (nonnull, nonatomic, strong, readonly) NSString *albumArtist;
@property (nonatomic, assign, readonly) int32_t albumID;
@property (nonnull, nonatomic, strong, readonly) NSString *releaseDate;
@property (nonatomic, assign, readonly) int32_t numberOfTracks;
@property (nonnull, nonatomic, strong, readonly) NSString *genre;
@property (nonnull, nonatomic, strong, readonly) NSString *price;
@property (nonnull, nonatomic, strong, readonly) NSString *country;
@property (nonnull, nonatomic, strong, readonly) NSString *explicitness;
@property (nonatomic, assign, readonly) int32_t artistID;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithAlbumName:(NSString *)albumName
                              albumArtist:(NSString *)name
                                  albumID:(int32_t)ID
                              releaseDate:(NSString *)date
                           numberOfTracks:(int32_t)number
                                    genre:(NSString *)genre
                                    price:(NSString *)price
                                  country:(NSString *)country
                              explictness:(NSString *)explicit
                                 artistID:(int32_t)artistID NS_DESIGNATED_INITIALIZER;
@end