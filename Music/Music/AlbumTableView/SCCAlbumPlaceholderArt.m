//
// Created by Daniel Burkle on 6/29/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAlbumPlaceholderArt.h"

@implementation SCCAlbumPlaceholderArt

static NSString *const SCCAlbumPlaceholderArtFileName = @"AlbumArt";
static NSString *const SCCAlbumPlaceHolderArtFileType = @"png";

+ (UIImageView *)placeholderArtFromLocalFile
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:SCCAlbumPlaceholderArtFileName ofType:SCCAlbumPlaceHolderArtFileType];
    UIImageView *placeholderArt = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filepath]];
    return placeholderArt;
}

@end