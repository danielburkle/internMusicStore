//
//  Created by Daniel Burkle on 6/2/17.
//  Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCTrack.h"

@implementation SCCTrack

static NSString *const TrackArtistName = @"artistName";
static NSString *const TrackArtistID = @"artistId";
static NSString *const TrackCollectionID = @"collectionId";
static NSString *const TrackCollectionName = @"collectionName";
static NSString *const TrackCountry = @"country";
static NSString *const TrackDiscCount = @"discCount";
static NSString *const TrackDiscNumber = @"discNumber";
static NSString *const TrackExplicitness = @"collectionExplicitness";
static NSString *const TrackGenreName = @"primaryGenreName";
static NSString *const TrackTrackPrice = @"trackPrice";
static NSString *const TrackTrackNumber = @"trackNumber";
static NSString *const TrackTrackDuration = @"trackTimeMillis";
static NSString *const TrackTrackID = @"trackId";
static NSString *const TrackTrackName = @"trackName";

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithDictionary:(NSDictionary <NSString *, id> *)dictionary
{
    self = [super init];
    if (self) {
        _albumID = [[dictionary objectForKey:TrackCollectionID] intValue];
        _albumName = [dictionary objectForKey:TrackCollectionName];
        _artistName = [dictionary objectForKey:TrackArtistName];
        _artistID = [[dictionary objectForKey:TrackArtistID] intValue];
        _country = [dictionary objectForKey:TrackCountry];
        _diskCount = [[dictionary objectForKey:TrackDiscCount] intValue];
        _diskNumber = [[dictionary objectForKey:TrackDiscNumber] intValue];
        _explicitness = [dictionary objectForKey:TrackExplicitness];
        _genre = [dictionary objectForKey:TrackGenreName];
        _price = [[dictionary objectForKey:TrackTrackPrice] floatValue];
        _duration = [[dictionary objectForKey:TrackTrackDuration] intValue];
        _name = [dictionary objectForKey:TrackTrackName];
        _trackNumber = [[dictionary objectForKey:TrackTrackNumber] intValue];
        _trackID = [[dictionary objectForKey:TrackTrackID] intValue];
    }
    return self;
}

#pragma mark - NSObject Implementation

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"Track: %@, Artist: %@, Album: %@, Price: %f,"
                                                                       " Track Number: %d, Disk Number: %d, Track Duration: %d, Genre: %@, Explicit: %@, AlbumID: %d, ArtistID: %d,"
                                                                       " Country: %@, Disk Count: %d, TrackID: %d",
                                                                   _name,
                                                                   _artistName,
                                                                   _albumName,
                                                                   _price,
                                                                   _trackNumber,
                                                                   _diskNumber,
                                                                   _duration,
                                                                   _genre,
                                                                   _explicitness,
                                                                   _albumID,
                                                                   _artistID,
                                                                   _country,
                                                                   _diskCount,
                                                                   _trackID];
    return descriptionString;
}

@end
