//
// Created by Daniel Burkle on 6/9/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAlbumTableViewCell.h"

#import "SCCImageUtility.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface SCCAlbumTableViewCell () {
    UIImageView *_albumArtImageView;
}

@end

static NSString *const SCCAlbumTableViewCellFileName = @"AlbumArt";
static NSString *const SCCAlbumTableViewCellFileType = @"png";

@implementation SCCAlbumTableViewCell

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
    _albumArtImageView = [SCCImageUtility albumPlaceHolderImageView];
}

- (void)updateAlbumArtWithAlbumURL:(NSString *)albumURL
{
    [_albumArtImageView sd_setImageWithURL:[NSURL URLWithString:albumURL]
                          placeholderImage:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@%@", SCCAlbumTableViewCellFileName, SCCAlbumTableViewCellFileType]]];
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
    NSArray<UILabel *> *albumLabels = @[ _albumName, _artistName, _releaseYear ];
    UIStackView *labelsStackView = [self verticalStackViewFromSubviews:albumLabels];
    NSArray<UIView *> *albumViews = @[ _albumArtImageView, labelsStackView ];
    UIStackView *outerStackView = [self horizontalStackViewFromSubviews:albumViews];
    [self activateAlbumArtSizeConstraints];
    [self activateConstraints:outerStackView];
}

- (void)activateConstraints:(nonnull UIStackView *)stackView
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
    [_albumArtImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_albumArtImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:70];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_albumArtImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_albumArtImageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [heightConstraint setPriority:999];
    [_albumArtImageView addConstraints:@[ widthConstraint, heightConstraint ]];
}

- (nonnull UIStackView *)verticalStackViewFromSubviews:(nonnull NSArray<UILabel *> *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    [stackView setSpacing:5];
    [stackView setDistribution:UIStackViewDistributionFillProportionally];
    [stackView setAlignment:UIStackViewAlignmentLeading];
    return stackView;
}

- (nonnull UIStackView *)horizontalStackViewFromSubviews:(nonnull NSArray<UIView *> *)subviews
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
