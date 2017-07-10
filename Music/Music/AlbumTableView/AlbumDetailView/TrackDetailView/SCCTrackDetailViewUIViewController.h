//
// Created by Daniel Burkle on 7/6/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;
@import UIKit;

@class SCCTrack;

@interface SCCTrackDetailViewUIViewController : UIViewController

@property (nonnull, nonatomic, strong, readwrite) UILabel *albumArtist;
@property (nonnull, nonatomic, strong, readwrite) UILabel *albumName;
@property (nonnull, nonatomic, strong, readwrite) UILabel *diskCount;
@property (nonnull, nonatomic, strong, readwrite) UILabel *diskNumber;
@property (nonnull, nonatomic, strong, readwrite) UILabel *trackDuration;
@property (nonnull, nonatomic, strong, readwrite) UILabel *trackExplicitness;
@property (nonnull, nonatomic, strong, readwrite) UILabel *trackName;
@property (nonnull, nonatomic, strong, readwrite) UILabel *trackNumber;
@property (nonnull, nonatomic, strong, readwrite) UILabel *trackPrice;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (nonnull instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

- (nonnull instancetype)initWithTrack:(nonnull SCCTrack *)track NS_DESIGNATED_INITIALIZER;

@end