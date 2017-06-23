//
// Created by Daniel Burkle on 6/9/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SubtitleTableViewCell.h"

@implementation SubtitleTableViewCell

#pragma mark - Object Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeLabels];
        [self applyAutoLayoutConstraints];
        [self applyFonts];
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)prepareForReuse
{
    [super prepareForReuse];

    [self applyFonts];
}

#pragma mark - Cell Customization

- (void)initializeLabels
{
    _albumName = [[UILabel alloc] init];
    _artistName = [[UILabel alloc] init];
    _releaseYear = [[UILabel alloc] init];
}

- (void)applyFonts
{
    [_albumName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [_artistName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_releaseYear setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
}

- (void)applyAutoLayoutConstraints
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[ _albumName, _artistName, _releaseYear ]];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    [stackView setSpacing:0];
    [stackView setDistribution:UIStackViewDistributionFillProportionally];
    [stackView setAlignment:UIStackViewAlignmentLeading];

    UIView *view = [self contentView];
    [view addSubview:stackView];

    UILayoutGuide *marginsGuide = [self layoutMarginsGuide];

    [NSLayoutConstraint activateConstraints:@[
        [[stackView leadingAnchor] constraintEqualToAnchor:[marginsGuide leadingAnchor]],
        [[stackView trailingAnchor] constraintEqualToAnchor:[marginsGuide trailingAnchor]],
        [[stackView topAnchor] constraintEqualToAnchor:[[view layoutMarginsGuide] topAnchor]],
        [[stackView bottomAnchor] constraintEqualToAnchor:[[view layoutMarginsGuide] bottomAnchor]]
    ]];
}

@end
