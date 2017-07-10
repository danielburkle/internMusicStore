//
// Created by Daniel Burkle on 6/29/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCImageUtility.h"

@implementation SCCImageUtility

static NSString *const SCCAlbumPlaceholderArtFileName = @"AlbumArt";
static NSString *const SCCAlbumPlaceHolderArtFileType = @"png";
static NSString *const SCCTrackPlaceHolderArtFileName = @"TrackArt";
static NSString *const SCCTrackPlaceHolderArtFileType = @"png";

+ (UIImageView *)albumPlaceHolderImageView
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:SCCAlbumPlaceholderArtFileName ofType:SCCAlbumPlaceHolderArtFileType];
    return [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filepath]];
}

+ (UIImageView *)trackPlaceHolderImageView
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:SCCTrackPlaceHolderArtFileName ofType:SCCTrackPlaceHolderArtFileType];
    return [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filepath]];
}

@end