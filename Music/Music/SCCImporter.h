//
// Created by Daniel Burkle on 7/17/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

@class SCCAlbum;

@interface SCCImporter : NSObject

+ (nullable NSArray<id> *)entityFromPath:(nonnull NSString *)path error:(NSError *_Nullable *_Nullable)error entityType:(nonnull NSString *)entityType;

@end