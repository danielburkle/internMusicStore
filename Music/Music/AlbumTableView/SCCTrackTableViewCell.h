//
// Created by Daniel Burkle on 6/30/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface SCCTrackTableViewCell : UITableViewCell

@property (nonnull, nonatomic, strong, readwrite) UILabel *trackDuration;
@property (nonnull, nonatomic, strong, readwrite) UILabel *trackName;
@property (nonnull, nonatomic, strong, readwrite) UILabel *trackNumber;

@end