//
//  Created by Daniel Burkle on 8/8/17.
//  Copyright © 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@interface SCCArtist : NSObject

@property (nonnull, nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) int32_t ID;
@property (nonnull, nonatomic, copy, readonly) NSString *genre;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary<NSString *, id> *)dictionary NS_DESIGNATED_INITIALIZER;

@end
