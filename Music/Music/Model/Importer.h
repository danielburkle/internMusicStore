//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Album.h"
#import "Track.h"

@interface Importer : NSObject

+ (nonnull NSArray<Album *> *)buildAlbumsFromJson;

+ (void)printAlbumDescription:(nonnull NSArray *)albumArray;

+ (nonnull NSArray<Track *> *)buildTracksFromJson;

+ (void)printTrackDescription:(nonnull NSArray *)trackArray;
@end