//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@interface Track : NSObject

@property (nonnull, nonatomic, copy, readonly) NSString *name;
@property (nonnull, nonatomic, copy, readonly) NSString *artistName;
@property (nonnull, nonatomic, copy, readonly) NSString *albumName;
@property (nonatomic, assign, readonly) float_t price;
@property (nonatomic, assign, readonly) int32_t trackNumber;
@property (nonatomic, assign, readonly) int32_t diskNumber;
@property (nonatomic, assign, readonly) int32_t duration;
@property (nonnull, nonatomic, copy, readonly) NSString *genre;
@property (nonnull, nonatomic, copy, readonly) NSString *explicitness;
@property (nonatomic, assign, readonly) int32_t albumID;
@property (nonatomic, assign, readonly) int32_t artistID;
@property (nonnull, nonatomic, copy, readonly) NSString *country;
@property (nonatomic, assign, readonly) int32_t diskCount;
@property (nonatomic, assign, readonly) int32_t trackID;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary <NSString *, id> *)trackDictionary NS_DESIGNATED_INITIALIZER;

@end
