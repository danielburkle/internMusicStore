//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@interface SCCAlbum : NSObject

@property (nonatomic, assign, readonly) int32_t albumID;
@property (nonatomic, assign, readonly) int32_t artistID;
@property (nonnull, nonatomic, copy, readonly) NSString *artistName;
@property (nonnull, nonatomic, copy, readonly) NSString *country;
@property (nonnull, nonatomic, copy, readonly) NSString *explicitness;
@property (nonnull, nonatomic, copy, readonly) NSString *genre;
@property (nonnull, nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) int32_t numberOfTracks;
@property (nonatomic, assign, readonly) float_t price;
@property (nonnull, nonatomic, copy, readonly) NSDate *releaseDate;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary<NSString *, id> *)dictionary NS_DESIGNATED_INITIALIZER;

@end