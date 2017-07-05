//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

#import "SCCAlbum.h"
#import "SCCTrack.h"

@interface SCCImporter : NSObject

+ (nonnull NSArray<SCCAlbum *> *)buildAlbumsFromJson;

+ (void)printAlbums:(nonnull NSArray<SCCAlbum *> *)albums;

+ (nonnull NSArray<SCCTrack *> *)buildTracksFromJson;

+ (void)printTracks:(nonnull NSArray<SCCTrack *> *)tracks;

@end