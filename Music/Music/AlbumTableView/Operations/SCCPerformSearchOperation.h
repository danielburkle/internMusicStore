//
// Created by Daniel Burkle on 7/12/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@class SCCAlbum;

@interface SCCPerformSearchOperation : NSOperation

@property (nullable, nonatomic, copy, readwrite) void(^operationCompletion)(NSArray<id> *_Nullable id, NSError *_Nullable error);

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithSearchCriteria:(nonnull NSString *)searchCriteria entityType:(nonnull NSString *)entityType NS_DESIGNATED_INITIALIZER;

@end