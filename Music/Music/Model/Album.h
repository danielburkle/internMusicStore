#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonnull, nonatomic, strong, readonly) NSString *albumName;
@property (nonnull, nonatomic, strong, readonly) NSString *albumArtist;
@property (nonatomic, assign, readonly) int32_t albumID;
@property (nonnull, nonatomic, strong, readonly) NSString *releaseDate;
@property (nonatomic, assign, readonly) int32_t numberOfTracks;
@property (nonnull, nonatomic, strong, readonly) NSString *genre;
@property (nonatomic, assign, readonly) float_t price;
@property (nonnull, nonatomic, strong, readonly) NSString *country;
@property (nonnull, nonatomic, strong, readonly) NSString *explicitness;
@property (nonatomic, assign, readonly) int32_t artistID;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithAlbumName:(nonnull NSString *)albumName
                              albumArtist:(nonnull NSString *)albumArtist
                                  albumID:(int32_t)albumID
                              releaseDate:(nonnull NSString *)releaseDate
                           numberOfTracks:(int32_t)numberOfTracks
                                    genre:(nonnull NSString *)genre
                                    price:(float_t)price
                                  country:(nonnull NSString *)country
                              explictness:(nonnull NSString *)explicitness
                                 artistID:(int32_t)artistID NS_DESIGNATED_INITIALIZER;
@end