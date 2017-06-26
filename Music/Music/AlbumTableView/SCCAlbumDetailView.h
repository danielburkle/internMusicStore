//
// Created by Daniel Burkle on 6/21/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;
@import UIKit;

@class Album;

@interface SCCAlbumDetailView : UITableViewController

@property (nonnull, nonatomic, strong, readonly) Album *album;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithAlbum:(Album *)album NS_DESIGNATED_INITIALIZER;

@end