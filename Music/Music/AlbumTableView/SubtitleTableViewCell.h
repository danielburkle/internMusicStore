//
// Created by Daniel Burkle on 6/9/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface SubtitleTableViewCell : UITableViewCell

@property (nonnull, nonatomic, strong) NSString *albumName;
@property (nonnull, nonatomic, strong) NSString *artistName;
@property (nonnull, nonatomic, strong) NSString *releaseYear;

+ (nonnull NSString *)cellReuseIdentifier;

@end