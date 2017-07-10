//
// Created by Daniel Burkle on 6/20/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SCCAlbumDetailHeaderView.h"

#import "SCCAlbum.h"
#import "SCCImageUtility.h"

@interface SCCAlbumDetailHeaderView () {
    SCCAlbum *_album;
    UIImageView *_albumArtImageView;
}

@end

@implementation SCCAlbumDetailHeaderView

static NSString *const SCCHeaderDetailViewExplicit = @"Explicit";

#pragma mark - Object Life Cycle

- (instancetype)init
{
    NSLog(@"Programmer Error! This initializer is init for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"Programmer Error! This initializer is initWithCoder for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    NSLog(@"Programmer Error! This initializer is initWithReuseIdentifier for %@, should not be used", NSStringFromClass([self class]));
    abort();
}

- (instancetype)initWithAlbum:(SCCAlbum *)album
{
    self = [super initWithReuseIdentifier:nil];
    if (self) {
        _album = album;
        [self configureHeader];
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)prepareForReuse
{
    [self applyFonts];
}

#pragma mark - Header Customization

- (void)configureHeader
{
    [self initializeAlbumArt];
    [self initializeLabels];
    [self updateLabelsForAlbum:_album];
    [self applyAutoLayoutConstraints];
    [self applyFonts];
    [[self contentView] setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)initializeAlbumArt
{
    _albumArtImageView = [SCCImageUtility albumPlaceHolderImageView];
}

- (void)initializeLabels
{
    _albumName = [[UILabel alloc] init];
    _artistName = [[UILabel alloc] init];
    _country = [[UILabel alloc] init];
    _explicitness = [[UILabel alloc] init];
    _genre = [[UILabel alloc] init];
    _releaseDate = [[UILabel alloc] init];
}

- (void)applyFonts
{
    [_albumName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [_artistName setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_country setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_explicitness setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_genre setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [_releaseDate setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
}

- (void)updateLabelsForAlbum:(nonnull SCCAlbum *)album
{
    [_albumName setText:[album name]];
    [_artistName setText:[album artistName]];
    [_country setText:[album country]];
    [_explicitness setText:[SCCAlbumDetailHeaderView formatExplicitness:[album explicitness]]];
    [_genre setText:[album genre]];
    [_releaseDate setText:[[self configuredDateFormatter] stringFromDate:[album releaseDate]]];
}

#pragma mark - Variable Formatting

+ (NSString *)formatExplicitness:(NSString *)explicitness
{
    if ([explicitness isEqualToString:SCCHeaderDetailViewExplicit]) {
        return [self localizedExplicit];
    } else {
        return [self localizedNotExplicit];
    }
}

- (nonnull NSDateFormatter *)configuredDateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return dateFormatter;
}

#pragma mark - Header Autolayout

- (void)applyAutoLayoutConstraints
{
    NSArray<UILabel *> *albumLabels = @[ _albumName, _artistName, _releaseDate, _explicitness, _genre, _country ];
    UIStackView *labelsStackView = [self verticalStackViewFromSubviews:albumLabels];
    NSArray<UIView *> *albumViews = @[ _albumArtImageView, labelsStackView ];
    UIStackView *outerStackView = [self horizontalStackViewFromSubviews:albumViews];
    [self applyAlbumArtSizeConstraints];
    [self applyConstraints:outerStackView];
}

- (void)applyConstraints:(nonnull UIStackView *)stackView
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

- (void)applyAlbumArtSizeConstraints
{
    [_albumArtImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_albumArtImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:110];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_albumArtImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_albumArtImageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [widthConstraint setPriority:999];
    [_albumArtImageView addConstraints:@[ widthConstraint, heightConstraint ]];
}

- (nonnull UIStackView *)verticalStackViewFromSubviews:(nonnull NSArray<UILabel *> *)subviews
{
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    [stackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stackView setAxis:UILayoutConstraintAxisVertical];
    [stackView setSpacing:0];
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
    [stackView setDistribution:UIStackViewDistributionFill];
    [stackView setAlignment:UIStackViewAlignmentLeading];
    return stackView;
}

#pragma mark - Localized Strings

+ (nonnull NSString *)localizedNotExplicit
{
    return @"Not Explicit";
}

+ (nonnull NSString *)localizedExplicit
{
    return @"Explicit";
}

@end