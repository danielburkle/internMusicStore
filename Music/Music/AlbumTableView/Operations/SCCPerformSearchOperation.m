//
// Created by Daniel Burkle on 7/12/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCPerformSearchOperation.h"

@interface SCCPerformSearchOperation () {
    NSString *_searchCriteria;
}
@end

@implementation SCCPerformSearchOperation

- (instancetype)initWithSearchCriteria:(NSString *)searchCriteria
{
    self = [super init];
    if (self){
        _searchCriteria = searchCriteria;
    }
    return self;
}

#pragma mark - NSOperation

- (void)main
{
    [NSThread sleepForTimeInterval:5.0f];
    if (![self isCancelled]) {
        _operationCompletion(nil);
    }
}

@end