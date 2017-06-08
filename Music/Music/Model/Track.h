//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@interface Track : NSObject

@property (nonnull, nonatomic, strong, readonly) NSString *name;
@property (nonnull, nonatomic, strong, readonly) NSString *artistName;
@property (nonnull, nonatomic, strong, readonly) NSString *albumName;
@property (nonatomic, assign, readonly) float_t price;
@property (nonatomic, assign, readonly) int32_t trackNumber;
@property (nonatomic, assign, readonly) int32_t diskNumber;
@property (nonatomic, assign, readonly) int32_t duration;
@property (nonnull, nonatomic, strong, readonly) NSString *genre;
@property (nonnull, nonatomic, strong, readonly) NSString *explicitness;
@property (nonatomic, assign, readonly) int32_t albumID;
@property (nonatomic, assign, readonly) int32_t artistID;
@property (nonnull, nonatomic, strong, readonly) NSString *country;
@property (nonatomic, assign, readonly) int32_t diskCount;
@property (nonatomic, assign, readonly) int32_t ID;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                  artistName:(nonnull NSString *)artistName
                   albumName:(nonnull NSString *)albumName
                       price:(float_t)price
                 trackNumber:(int32_t)trackNumber
                  diskNumber:(int32_t)diskNumber
                    duration:(int32_t)duration
                       genre:(nonnull NSString *)genre
                 explictness:(nonnull NSString *)explicitness
                     albumID:(int32_t)albumID
                    artistID:(int32_t)artistID
                     country:(nonnull NSString *)country
                   diskCount:(int32_t)diskCount
                          ID:(int32_t)ID NS_DESIGNATED_INITIALIZER;

@end
