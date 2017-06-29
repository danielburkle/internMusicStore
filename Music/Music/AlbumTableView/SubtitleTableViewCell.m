//
// Created by Daniel Burkle on 6/9/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SubtitleTableViewCell.h"

#import "SCCAlbumPlaceholderArt.h"

@interface SubtitleTableViewCell () {
    UIImageView *_albumArt;
}

@end

@implementation SubtitleTableViewCell

#pragma mark - Object Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCell];
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

- (void)configureCell
{
    [self initializeAlbumArt];
    [self initializeLabels];
    [self applyAutoLayoutConstraints];
    [self applyFonts];
}

- (void)initializeAlbumArt
{
    _albumArt = [SCCAlbumPlaceholderArt placeholderArtFromLocalFile];
}

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
    NSArray *albumLabels = @[ _albumName, _artistName, _releaseYear ];
    UIStackView *labelsStackView = [self verticalStackViewFromSubviews:albumLabels];
    NSArray *albumViews = @[ _albumArt, labelsStackView ];
    UIStackView *outerStackView = [self horizontalStackViewFromSubviews:albumViews];
    [self activateAlbumArtSizeConstraints];
    [self activateConstraints:outerStackView];
}

- (void)activateConstraints:(UIStackView *)stackView
{
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

- (void)activateAlbumArtSizeConstraints
{
    [_albumArt setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_albumArt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:70];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_albumArt attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_albumArt attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [_albumArt addConstraints:@[ widthConstraint, heightConstraint ]];
}

- (UIStackView *)verticalStackViewFromSubviews:(NSArray *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    [stackView setSpacing:5];
    [stackView setDistribution:UIStackViewDistributionFillProportionally];
    [stackView setAlignment:UIStackViewAlignmentLeading];
    return stackView;
}

- (UIStackView *)horizontalStackViewFromSubviews:(NSArray *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisHorizontal];
    [stackView setSpacing:15];
    [stackView setDistribution:UIStackViewDistributionFillProportionally];
    [stackView setAlignment:UIStackViewAlignmentLeading];
    return stackView;
}

@end
