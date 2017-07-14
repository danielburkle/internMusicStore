//
// Created by Daniel Burkle on 7/12/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@class SCCAlbum;

@interface SCCPerformSearchOperation : NSOperation

@property (nullable, nonatomic, copy, readwrite) void(^operationCompletion)(NSArray<SCCAlbum *> *_Nullable album, NSError *_Nullable error);

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithSearchCriteria:(nonnull NSString *)searchCriteria NS_DESIGNATED_INITIALIZER;

@end