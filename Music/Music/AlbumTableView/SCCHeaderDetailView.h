//
// Created by Daniel Burkle on 6/20/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;
@import UIKit;

@class Album;

@interface SCCHeaderDetailView : UITableViewHeaderFooterView

@property (nonnull, nonatomic, strong, readwrite) UILabel *albumName;
@property (nonnull, nonatomic, strong, readwrite) UILabel *artistName;
@property (nonnull, nonatomic, strong, readwrite) UILabel *country;
@property (nonnull, nonatomic, strong, readwrite) UILabel *explicitness;
@property (nonnull, nonatomic, strong, readwrite) UILabel *genre;
@property (nonnull, nonatomic, strong, readwrite) UILabel *releaseDate;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier NS_UNAVAILABLE;

- (nonnull instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

- (nonnull instancetype)initWithAlbum:(nonnull Album *)album NS_DESIGNATED_INITIALIZER;

@end
