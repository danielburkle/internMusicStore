//
// Created by Daniel Burkle on 6/9/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface SubtitleTableViewCell : UITableViewCell

@property (nonnull, nonatomic, strong, readwrite) UILabel *albumName;
@property (nonnull, nonatomic, strong, readwrite) UILabel *artistName;
@property (nonnull, nonatomic, strong, readwrite) UILabel *releaseYear;

@end