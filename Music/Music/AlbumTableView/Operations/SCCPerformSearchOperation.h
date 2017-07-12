//
// Created by Daniel Burkle on 7/12/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@interface SCCPerformSearchOperation : NSOperation

@property (nullable, nonatomic, copy, readwrite) void(^operationCompletion)(NSError *_Nullable error);

- (nonnull instancetype)initWithSearchCriteria:(nonnull NSString *)searchCriteria;

@end