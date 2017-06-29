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

- (nonnull instancetype)initWithStyle:(UITableViewStyle)style NS_UNAVAILABLE;

- (nonnull instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

- (nonnull instancetype)initWithAlbum:(nonnull Album *)album NS_DESIGNATED_INITIALIZER;

@end