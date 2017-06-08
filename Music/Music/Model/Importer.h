//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;

#import "Album.h"
#import "Track.h"

@interface Importer : NSObject

+ (nonnull NSArray<Album *> *)buildAlbumsFromJson;

+ (void)printAlbumDescription:(nonnull NSArray<Album *> *)albumArray;

+ (nonnull NSArray<Track *> *)buildTracksFromJson;

+ (void)printTrackDescription:(nonnull NSArray<Track *> *)trackArray;

@end