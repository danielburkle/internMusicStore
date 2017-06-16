//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@interface Album : NSObject

@property (nonnull, nonatomic, copy, readonly) NSString *name;
@property (nonnull, nonatomic, copy, readonly) NSString *artistName;
@property (nonatomic, assign, readonly) int32_t albumID;
@property (nonnull, nonatomic, copy, readonly) NSDate *releaseDate;
@property (nonatomic, assign, readonly) int32_t numberOfTracks;
@property (nonnull, nonatomic, copy, readonly) NSString *genre;
@property (nonatomic, assign, readonly) float_t price;
@property (nonnull, nonatomic, copy, readonly) NSString *country;
@property (nonnull, nonatomic, copy, readonly) NSString *explicitness;
@property (nonatomic, assign, readonly) int32_t artistID;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary<NSString *, id> *)albumDictionary NS_DESIGNATED_INITIALIZER;


@end